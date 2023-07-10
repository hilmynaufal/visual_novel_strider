import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/model/kana_model/individual_result.dart';
import 'package:visual_novel_strider/model/kana_model/response_result.dart';
import 'package:visual_novel_strider/model/kana_model/trait.dart';
import 'package:visual_novel_strider/service/socket_server.dart';
import 'package:visual_novel_strider/service/vndb_api_kana_v2.dart';
import 'package:visual_novel_strider/utils/constant/color_constant.dart';

import '../model/old_socket_model/character_result.dart';
import '../model/old_socket_model/release_result.dart';

class CharactersRepository extends GetxController {
  // final SocketServer _server = Get.find();
  final KanaServer _kanaServer = Get.find();

  Rx<ResponseResult> result = ResponseResult(more: false, results: []).obs;
  Rx<ResponseResult> individualResult =
      ResponseResult(more: false, results: []).obs;
  // Rx<ReleaseResult> releaseResult =
  //     ReleaseResult(num: 0, more: false, items: null).obs;

  RxBool isReady = false.obs;

  Rx<int?> individualColor = 0.obs;

  @override
  void onReady() {
    result.bindStream(_kanaServer.charactersController.stream);
    // releaseResult.bindStream(_server.firstReleaseController.stream);
  }

  Future<void> getCharacters(String id) async {
    log("requesting api characters");
    await _kanaServer.getCharacters(id);
    isReady.value = true;
    // update();
  }

  Future<void> getIndividualDetail(String id) async {
    log("requesting api individual detail");
    final ResponseResult _response = await _kanaServer.getIndividual(
        jsonBody: jsonEncode(<String, dynamic>{
          "filters": ["id", "=", id],
          "fields":
              "name, original, description, sex, age, vns.role, image.url, vns.spoiler, traits.name, traits.group_name, traits.description, birthday",
          // "results": "100"
        }),
        headers: "");
    if (_response.results.isNotEmpty) {
      individualResult.value = _response;
      List<Trait> trait = _response.results.first.traits;

      individualColor.value = await compute(getColor, trait);
    }
  }

  static int? getColor(List<Trait> trait) {
    return ColorConstant.hairColor[int.parse(trait
        .firstWhereOrNull((element) {
          Trait e = element;
          for (int key in ColorConstant.hairColor.keys) {
            if (int.parse(e.id.replaceAll("i", "")) == key) {
              return true;
            }
          }
          return false;
        })!
        .id
        .replaceAll("i", ""))];
  }

  Future<void> getFirstRelease(int id) async {}
}
