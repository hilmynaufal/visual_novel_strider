import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:visual_novel_strider/entity/tag_entity.dart';
import 'package:visual_novel_strider/model/tags_result.dart';

import 'package:http/http.dart' as http;
import 'package:visual_novel_strider/tag_dao.dart';

import 'database/database.dart';

class HttpClient {
  late final database;
  late List<TagEntity> tags;

  late final TagDao tagDao;

  static const link = "https://dl.vndb.org/dump/vndb-tags-latest.json.gz";

  HttpClient() {
    initTags();
  }

  Future<void> initTags() async {
    database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    tagDao = database.tagDao;
    final response = await http.get(Uri.parse(link));
    String son = utf8.decode(GZipCodec().decode(response.bodyBytes));

    log("son");
    List<dynamic> list = jsonDecode(son);
    // List<TagsResult> tagresult =

    for (int i = 0; i < list.length; i++) {
      final TagEntity tagEntity = TagEntity(
          applicable: list[i]["applicable"],
          cat: list[i]["cat"],
          description: list[i]["description"],
          id: list[i]["id"],
          meta: list[i]["meta"],
          name: list[i]["name"],
          parents: list[i]["parents"].length != 0 ? list[i]["parents"][0] : 0,
          searchable: list[i]["searchable"],
          vns: list[i]["vns"]);
      await tagDao.insertTag(tagEntity);
    }
  }

  Future<List<TagEntity?>> getTagsEntity(List<int> tags) {
    List<TagEntity?> result;

    return tagDao.findTagById(tags);
  }

  // Future<void> getTagFromLocal() async {
  //   database =
  //       await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  //   final TagEntity tagEntity = TagEntity(
  //       applicable: false,
  //       cat: "cat",
  //       description: "description",
  //       id: 1,
  //       meta: true,
  //       name: "name",
  //       parents: 2,
  //       searchable: true,
  //       vns: 22);

  //   final TagDao tagDao = database.tagDao;
  //   await tagDao.insertTag(tagEntity);

  //   List<TagEntity> result = await tagDao.findAllTags();

  //   for (int i = 0; i < result.length; i++) {
  //     log(result[i].id.toString());
  //   }
  // }
}
