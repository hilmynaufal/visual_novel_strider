import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:visual_novel_strider/model/kana_model/response_result.dart';

class KanaServer extends GetxController {
  static const String URL = "https://api.vndb.org/kana/";

  // RxBool isReady = false.obs;

  final StreamController<ResponseResult> searchController =
      StreamController<ResponseResult>();
  final StreamController<ResponseResult> detailController =
      StreamController<ResponseResult>();
  final StreamController<ResponseResult> charactersController =
      StreamController<ResponseResult>();
  final StreamController<ResponseResult> newReleasedController =
      StreamController<ResponseResult>();
  final StreamController<ResponseResult> popularController =
      StreamController<ResponseResult>();
  final StreamController<ResponseResult> nakigeController =
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
              "name, description, sex, age, vns.role, image.url, vns.spoiler"
        }));

    if (response.statusCode == 200) {
      charactersController
          .add(ResponseResult.fromCharactersJson(jsonDecode(response.body)));
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

  Future<void> getBatchVisualNovel(String sort, String controller,
      {String? tags,
      String? releaseDate,
      String? olang,
      required int filterCount}) async {
    final requestBody = json.encode(<String, dynamic>{
      "filters": filterCount == 0
          ? []
          : _filtersFactory(filterCount, tags, releaseDate, olang),
      "fields":
          "title, alttitle, image.url, released, rating, languages, image.url, image.sexual, image.violence",
      "results": 20,
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
      switch (controller) {
        case "new":
          newReleasedController
              .add(ResponseResult.fromJson(jsonDecode(response.body)));
          break;
        case "popularity":
          popularController
              .add(ResponseResult.fromJson(jsonDecode(response.body)));
          break;
        case "nakige":
          nakigeController
              .add(ResponseResult.fromJson(jsonDecode(response.body)));
          break;
        default:
      }
      // searchController.add(SearchResult.fromJson(jsonDecode(response.body)));
      log(response.body);
    } else {
      log("error is in = " + controller + " controller");
    }
  }

  List<dynamic> _filtersFactory(int filterCount, tags, releaseDate, olang) {
    List<dynamic> newFilters = [];

    newFilters.add("and");

    if (tags != null) newFilters.add(["tag", "=", tags]);
    if (releaseDate != null) newFilters.add(["released", ">=", releaseDate]);
    if (olang != null) newFilters.add(["olang", "=", olang]);

    return newFilters;
  }
}
