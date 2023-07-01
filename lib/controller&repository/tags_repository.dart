import 'dart:developer';

import 'package:get/get.dart';
import 'package:visual_novel_strider/entity/tag_entity.dart';
import 'package:visual_novel_strider/entity/trait_entity.dart';
import 'package:visual_novel_strider/service/http_client.dart';

class TagsRepository extends GetxController {
  // final HttpClient _httpClient = HttpClient();
  // List<TagEntity?> entity = [];
  // List<TraitEntity?> traits = [];
  // bool isReady = false;
  // RxBool isTraitReady = true.obs;
  // final Rx<TagEntity?> data = TagEntity(
  //         applicable: false,
  //         cat: "",
  //         description: "",
  //         id: 0,
  //         meta: false,
  //         name: "",
  //         parents: 0,
  //         searchable: false,
  //         vns: 0)
  //     .obs;
  // final Rx<TraitEntity> traitObs = TraitEntity(
  //         applicable: false,
  //         description: "",
  //         id: 0,
  //         meta: false,
  //         name: "",
  //         parents: 0,
  //         searchable: false)
  //     .obs;
  // final List<int> hairColor = [
  //   8,
  //   7,
  //   956,
  //   6,
  //   1305,
  //   10,
  //   9,
  //   4,
  //   50,
  //   919,
  //   926,
  //   5,
  //   11
  // ];
  // final List<int> eyesColor = [
  //   110,
  //   53,
  //   113,
  //   727,
  //   112,
  //   927,
  //   114,
  //   115,
  //   906,
  //   108,
  //   109,
  //   111,
  //   921
  // ];
  // @override
  // void onReady() {
  //   _httpClient.initTags();
  // }

  // void getTags(List<List<double>> a) async {
  //   isReady = false;

  //   List<int> id = [0];
  //   for (int i = 0; i < a.length; i++) {
  //     id.add(a[i][0].toInt());
  //   }
  //   List<TagEntity?> _temp;
  //   _temp = await _httpClient.getTagsEntity(id);

  //   entity = [];

  //   a.sort((x, y) => x.indexOf(1).compareTo(y.indexOf(1)));
  //   a = a.reversed.toList();

  //   log(a[0][1].toString());

  //   for (int i = 0; i < _temp.length; i++) {
  //     if (_temp[i]!.cat == "cont") {
  //       entity.add(_temp[i]);
  //     }
  //   }

  //   isReady = true;

  //   update();
  // }

  // void getTraits(List<List<dynamic>> a) async {
  //   isTraitReady.value = false;

  //   int hairId = 0;
  //   int eyesId = 0;
  //   for (int i = 0; i < a.length; i++) {
  //     if (hairColor.contains((a[i][0].toInt()))) {
  //       hairId = (a[i][0].toInt());
  //     } else if (eyesColor.contains((a[i][0].toInt()))) {
  //       eyesId = (a[i][0].toInt());
  //     }
  //   }
  //   List<TraitEntity?> _tempEyes;
  //   _tempEyes = await _httpClient.getTraitEntity([eyesId]);

  //   List<TraitEntity?> _tempHair;
  //   _tempHair = await _httpClient.getTraitEntity([hairId]);

  //   traits = [];

  //   TraitEntity _placeholder = TraitEntity(
  //       applicable: false,
  //       description: "",
  //       id: 0,
  //       meta: false,
  //       name: "None",
  //       parents: 0,
  //       searchable: false);

  //   if (_tempEyes.isNotEmpty) {
  //     traits.add(_tempEyes[0]);
  //   } else {
  //     traits.add(_placeholder);
  //   }
  //   if (_tempHair.isNotEmpty) {
  //     traits.add(_tempHair[0]);
  //   } else {
  //     traits.add(_placeholder);
  //   }

  //   isTraitReady.value = true;

  //   update();
  // }
}
