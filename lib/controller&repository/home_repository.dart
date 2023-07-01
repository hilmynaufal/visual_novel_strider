import 'dart:developer';

import 'package:get/get.dart';
import 'package:visual_novel_strider/model/kana_model/response_result.dart';
import 'package:visual_novel_strider/service/socket_server.dart';
import 'package:visual_novel_strider/utils/datetime_parse.dart';

import '../model/old_socket_model/result.dart';
import '../service/vndb_api_kana_v2.dart';

class HomeRepository extends GetxController {
  // final SocketServer server = Get.find();

  final KanaServer _server = Get.find();

  Rx<ResponseResult> result = ResponseResult(results: [], more: false).obs;
  Rx<ResponseResult> popularResult =
      ResponseResult(results: [], more: false).obs;
  Rx<ResponseResult> nakigeResult =
      ResponseResult(results: [], more: false).obs;

  RxBool isReady = true.obs;

  @override
  void onReady() async {
    result.bindStream(_server.newReleasedController.stream);
    popularResult.bindStream(_server.popularController.stream);
    nakigeResult.bindStream(_server.nakigeController.stream);
    // isReady.value = true;
  }

  Future<void> getNewReleased() async {
    // isReady.value = false;
    log("requesting kana api home");
    await _server.getBatchVisualNovel("rating", "new",
        releaseDate: DateTimeParse.getFirstDayInMonth(),
        olang: "ja",
        filterCount: 2);
    isReady.value = true;
    update();
  }

  Future<void> getMostPopular() async {
    // isReady.value = false;
    log("requesting kana api popular");
    await _server.getBatchVisualNovel("popularity", "popularity",
        filterCount: 0);
    isReady.value = true;
    update();
  }

  Future<void> getNakige() async {
    // isReady.value = false;
    log("requesting kana api nakige");
    await _server.getBatchVisualNovel("rating", "nakige",
        tags: "g596", filterCount: 1);
    isReady.value = true;
    update();
  }
}
