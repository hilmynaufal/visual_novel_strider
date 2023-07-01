import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:visual_novel_strider/model/release_result.dart';
import 'package:visual_novel_strider/service/socket_server.dart';

import '../model/character_result.dart';

class CharactersRepository extends GetxController {
  final SocketServer _server = Get.find();

  Rx<CharacterResult> result =
      CharacterResult(num: 0, more: false, charaItems: null).obs;
  Rx<ReleaseResult> releaseResult =
      ReleaseResult(num: 0, more: false, items: null).obs;

  RxBool isReady = false.obs;

  @override
  void onReady() {
    result.bindStream(_server.characterController.stream);
    releaseResult.bindStream(_server.firstReleaseController.stream);
  }

  void getCharacters(int id) async {
    isReady.value = false;
    await _server.getCharaFromDatabase(id, "a", () async {
      await getFirstRelease(id);
      isReady.value = true;
      update();
    }, "character");
  }

  Future<void> getFirstRelease(int id) async {
    await _server.getRelease("release", id, () {
      isReady.value = true;
      update();
    });
  }
}
