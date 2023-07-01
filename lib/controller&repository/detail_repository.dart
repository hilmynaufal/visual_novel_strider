import 'dart:developer';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';
import 'package:visual_novel_strider/model/kana_model/response_result.dart';
import 'package:visual_novel_strider/service/vndb_api_kana_v2.dart';

class DetailRepository extends GetxController {
  //TODO: detail repo

  final KanaServer _kanaServer = Get.find();

  Rx<ResponseResult> detailResult =
      ResponseResult(results: [], more: false).obs;

  @override
  void onReady() {
    detailResult.bindStream(_kanaServer.detailController.stream);
  }

  Future<void> getDetail(String id) async {
    log("requesting api vn detail");
    await _kanaServer.getVNDetail(id);
    update();
  }
}