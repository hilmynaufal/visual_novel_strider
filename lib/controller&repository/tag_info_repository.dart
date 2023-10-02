import 'dart:convert';

import 'package:get/get.dart';
import 'package:visual_novel_strider/model/kana_model/tag_result.dart';
import 'package:visual_novel_strider/service/vndb_api_kana_v2.dart';

class TagInfoRepository extends GetxController {
  final KanaServer kanaServer = Get.find();

  final similarTagList = RxList<Map<String, String>>();
  final currentTag = Rxn<TagResult>();
  var tagDescription = "";
  final isReady = false.obs;

  Future<void> getTagInfo(String id) async {
    isReady.value = false;
    final response = await kanaServer.newpostApiCall(
        headers: 'tag',
        jsonBody: jsonEncode(<String, dynamic>{
          "filters": ["id", "=", id],
          "fields": "id, name, aliases, description, category, vn_count",
        }));
    tagDescription = jsonDecode(response!.body)['results']['description'];
    isReady.value = true;
  }

  Future<void> getSimilarTagList(String tagId, String vnId) async {
    // isReady.value = false;
    final response = await kanaServer.newpostApiCall(
        headers: 'vn',
        jsonBody: jsonEncode(<String, dynamic>{
          "filters": [
            "and",
            ["tag", "=", tagId],
            ["id", "!=", vnId]
          ],
          "fields":
              "title, alttitle, image.url, released, rating, languages, image.url, image.sexual, image.violence, description, popularity, votecount",
          "results": 3,
          "reverse": true,
          "sort": "rating"
        }));
    similarTagList.value = List.from(jsonDecode(response!.body)['results']);
    // isReady.value = true;
  }

  void decryptJson(response) {}
}
