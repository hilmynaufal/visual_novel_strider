import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:visual_novel_strider/model/chara_item.dart';
import 'package:visual_novel_strider/model/gender.dart';
import 'package:visual_novel_strider/socket_server.dart';

import 'model/character_result.dart';

class CharactersRepository extends GetxController {
  final SocketServer _server = Get.find();

  Rx<CharacterResult> result =
      CharacterResult(num: 0, more: false, charaItems: null).obs;

  RxBool isReady = false.obs;

  @override
  void onReady() {
    result.bindStream(_server.characterController.stream);
  }

  void getCharacters(int id) async {
    result.value = CharacterResult(num: 0, more: false, charaItems: null);
    isReady.value = false;
    await _server.getCharaFromDatabase(id, "a", () async {}, "character");
    isReady.value = true;
    update();
  }
}
