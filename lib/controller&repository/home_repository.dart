import 'dart:developer';

import 'package:get/get.dart';
import 'package:visual_novel_strider/model/kana_model/response_result.dart';
import 'package:visual_novel_strider/utils/datetime_parse.dart';

import '../service/vndb_api_kana_v2.dart';

class HomeRepository extends GetxController {
  // final SocketServer server = Get.find();

  final KanaServer _server = Get.find();

  Rx<ResponseResult> result = ResponseResult(results: [], more: false).obs;
  Rx<ResponseResult> popularResult =
      ResponseResult(results: [], more: false).obs;
  Rx<ResponseResult> nakigeResult =
      ResponseResult(results: [], more: false).obs;
  Rx<ResponseResult> yuzusoftResult =
      ResponseResult(results: [], more: false).obs;
  Rx<ResponseResult> keyResult = ResponseResult(results: [], more: false).obs;

  RxBool isReady = true.obs;

  Future<void> getNewReleased() async {
    // isReady.value = false;
    log("requesting kana api home");
    var response = await _server.getBatchVisualNovel("rating", "new",
        releaseDate: DateTimeParse.getFirstDayInMonth(),
        olang: "ja",
        filterCount: 2,
        itemCount: 20);
    result.value = response;
    isReady.value = true;
    update();
  }

  Future<void> getMostPopular() async {
    // isReady.value = false;
    log("requesting kana api popular");

    var response = await _server.getBatchVisualNovel("popularity", "popularity",
        filterCount: 0, itemCount: 20);
    popularResult.value = response;
    isReady.value = true;
    update();
  }

  Future<void> getNakige() async {
    // isReady.value = false;
    log("requesting kana api nakige");

    var response = await _server.getBatchVisualNovel("rating", "nakige",
        tags: "g596", filterCount: 1, itemCount: 20);
    nakigeResult.value = response;
    isReady.value = true;
    update();
  }

  Future<void> getYuzusoft() async {
    // isReady.value = false;
    log("requesting kana api yuzusoft");

    var response = await _server.getBatchVisualNovel("rating", "developer",
        dev: "p98", filterCount: 1, itemCount: 5);
    yuzusoftResult.value = response;
    isReady.value = true;
    update();
  }

  void getKey() async {
    // isReady.value = false;
    log("requesting kana api key");

    var response = await _server.getBatchVisualNovel("rating", "developer",
        dev: "p24", filterCount: 1, itemCount: 5);
    keyResult.value = response;
    isReady.value = true;
    update();
  }
}
