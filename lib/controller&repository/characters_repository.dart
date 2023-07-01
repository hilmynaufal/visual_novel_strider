import 'dart:developer';

import 'package:get/get.dart';
import 'package:visual_novel_strider/model/kana_model/response_result.dart';
import 'package:visual_novel_strider/service/socket_server.dart';
import 'package:visual_novel_strider/service/vndb_api_kana_v2.dart';

import '../model/old_socket_model/character_result.dart';
import '../model/old_socket_model/release_result.dart';

class CharactersRepository extends GetxController {
  // final SocketServer _server = Get.find();
  final KanaServer _kanaServer = Get.find();

  Rx<ResponseResult> result = ResponseResult(more: false, results: []).obs;
  // Rx<ReleaseResult> releaseResult =
  //     ReleaseResult(num: 0, more: false, items: null).obs;

  RxBool isReady = false.obs;

  @override
  void onReady() {
    result.bindStream(_kanaServer.charactersController.stream);
    // releaseResult.bindStream(_server.firstReleaseController.stream);
  }

  Future<void> getCharacters(String id) async {
    log("requesting api characters");
    await _kanaServer.getCharacters(id);
    update();
  }

  Future<void> getFirstRelease(int id) async {}
}
