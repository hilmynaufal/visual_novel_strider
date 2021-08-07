import 'dart:developer';

import 'package:get/get.dart';
import 'package:visual_novel_strider/entity/tag_entity.dart';
import 'package:visual_novel_strider/http_client.dart';

import 'model/tags_result.dart';

class TagsRepository extends GetxController {
  final HttpClient _httpClient = HttpClient();
  List<TagEntity?> entity = [];
  bool isReady = false;
  final Rx<TagEntity?> data = TagEntity(
          applicable: false,
          cat: "",
          description: "",
          id: 0,
          meta: false,
          name: "",
          parents: 0,
          searchable: false,
          vns: 0)
      .obs;

  @override
  void onReady() {
    _httpClient.initTags();
  }

  void getTags(List<List<double>> a) async {
    isReady = false;

    List<int> id = [0];
    for (int i = 0; i < a.length; i++) {
      id.add(a[i][0].toInt());
    }
    List<TagEntity?> _temp;
    _temp = await _httpClient.getTagsEntity(id);

    entity = [];

    for (int i = 0; i < _temp.length; i++) {
      if (_temp[i]!.cat == "cont") {
        entity.add(_temp[i]);
      }
    }
    log(entity[0]!.name.toString());

    isReady = true;

    update();
  }
}
