import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:visual_novel_strider/model/kana_model/response_result.dart';
import 'package:visual_novel_strider/model/kana_model/result.dart';

class KanaServer extends GetxController {
  static const String URL = "https://api.vndb.org/kana/";

  // RxBool isReady = false.obs;

  final StreamController<ResponseResult> searchController =
      StreamController<ResponseResult>();
  final StreamController<ResponseResult> detailController =
      StreamController<ResponseResult>();
  final StreamController<ResponseResult> charactersController =
      StreamController<ResponseResult>();

  Future<void> searchVisualNovel(String query) async {
    final response = await http.post(Uri.parse(URL + "vn"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(<String, dynamic>{
          "filters": ["search", "=", query],
          "fields":
              "title, alttitle, image.url, released, rating, languages, image.url, image.sexual, image.violence"
        }));

    if (response.statusCode == 200) {
      searchController.add(ResponseResult.fromJson(jsonDecode(response.body)));
    } else {
      log("error");
      log(response.body);
    }
  }

  Future<void> getCharacters(String id) async {
    final response = await http.post(Uri.parse(URL + "character"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(<String, dynamic>{
          "filters": [
            "vn",
            "=",
            ["id", "=", id]
          ],
          "fields":
              "name, original, description, sex, age, vns.role, image.url, vns.spoiler, traits.name, traits.group_name, birthday",
          "results": "100"
        }));

    if (response.statusCode == 200) {
      charactersController.add(
          ResponseResult.fromIndividualDetailJson(jsonDecode(response.body)));
    } else {
      log("error");
      log(response.body);
    }
  }

  Future<void> getVNDetail(String id) async {
    final response = await http.post(Uri.parse(URL + "vn"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(<String, dynamic>{
          "filters": ["id", "=", id],
          "fields":
              "title, alttitle, image.url, released, rating, languages, image.url, image.sexual, image.violence, description, popularity, votecount, screenshots.url, tags.id, tags.name, tags.rating, tags.spoiler, olang, length"
        }));

    if (response.statusCode == 200) {
      detailController
          .add(ResponseResult.fromDetailJson(jsonDecode(response.body)));
      log(response.body);
    } else {
      log("error");
      log(response.body);
    }
  }

  Future<ResponseResult> getBatchVisualNovel(String sort, String controller,
      {String? tags,
      String? releaseDate,
      String? olang,
      String? dev,
      String? vnId,
      required int filterCount,
      required int itemCount}) async {
    final requestBody = json.encode(<String, dynamic>{
      "filters": filterCount == 0
          ? []
          : _filtersFactory(filterCount, vnId, tags, releaseDate, olang, dev),
      "fields":
          "title, alttitle, image.url, released, rating, languages, image.url, image.sexual, image.violence",
      "results": itemCount,
      "sort": sort,
      "reverse": true
    });
    final response = await http.post(Uri.parse(URL + "vn"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBody);

    log(requestBody);
    if (response.statusCode == 200) {
      log(response.body);
      return ResponseResult.fromJson(jsonDecode(response.body));
    }
    // searchController.add(SearchResult.fromJson(jsonDecode(response.body)));
    else {
      log("error is in = " + controller + " controller");
      return ResponseResult(results: [], more: false);
    }
  }

  List<dynamic> _filtersFactory(
      int filterCount, vnId, tags, releaseDate, olang, dev) {
    List<dynamic> newFilters = [];

    newFilters.add("and");

    if (tags != null) newFilters.add(["tag", "=", tags]);
    if (releaseDate != null) newFilters.add(["released", ">=", releaseDate]);
    if (olang != null) newFilters.add(["olang", "=", olang]);
    if (dev != null) {
      newFilters.add([
        "developer",
        "=",
        ["id", "=", dev]
      ]);
    }

    return newFilters;
  }

  //testing new algorithm
  Future<ResponseResult> getIndividual(
      {required String jsonBody, required String headers}) async {
    final _response = await http.post(Uri.parse(URL + "character"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonBody);

    if (_response.statusCode == 200) {
      log(_response.body);
      return ResponseResult.fromIndividualDetailJson(
          jsonDecode(_response.body));
    } else {
      log("error");
      log(_response.body);
      return ResponseResult(results: [], more: false);
    }
  }
}
