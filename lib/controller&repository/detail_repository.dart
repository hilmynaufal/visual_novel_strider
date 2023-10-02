import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:visual_novel_strider/model/kana_model/response_result.dart';
import 'package:visual_novel_strider/service/vndb_api_kana_v2.dart';

class DetailRepository extends GetxController {
  //TODO: detail repo

  final KanaServer _kanaServer = Get.find();

  final detailResult = ResponseResult(results: [], more: false).obs;

  final releaseResult =
      Rx<ResponseResult>(ResponseResult(more: false, results: []));
  int releasePagination = 1;

  var isReady = false.obs;
  final isReleaseReady = false.obs;

  Future<void> getDetail(String id) async {
    isReady.value = false;
    log("requesting api vn detail");
    detailResult.value = await _kanaServer.getVNDetail(id);
    isReady.value = true;
    update();
  }

  Future<void> getReleaseDetail(String id) async {
    isReleaseReady.value = false;
    log("requesting api release detail");

    ResponseResult? result = await _kanaServer.postApiCall(
        headers: "release",
        jsonBody: jsonEncode(<String, dynamic>{
          "filters": [
            "vn",
            "=",
            ["id", "=", id]
          ],
          "fields":
              "id, title, languages.lang, platforms, media.medium, vns.rtype, producers.developer, producers.name, producers.publisher, released, minage, official, voiced",
          "results": 10,
          "page": releasePagination,
          "sort": "released"
        }));

    if (result != null) {
      releaseResult.value.results.addAll(result.results);
      releaseResult.value.more = result.more;
      releasePagination += 1;
    }

    isReleaseReady.value = true;
    update();
  }
}
