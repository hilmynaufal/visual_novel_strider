// ignore_for_file: prefer_typing_uninitialized_variables

// class HttpClient {
//   late final database;

//   late final TagDao tagDao;
//   late final TraitsDao traitsDao;

//   static const link = "https://dl.vndb.org/dump/vndb-tags-latest.json.gz";
//   static const traitLink =
//       "https://dl.vndb.org/dump/vndb-traits-latest.json.gz";

//   HttpClient() {
//     // compute(initTags);
//   }

//   void initTags() async {
//     database =
//         await $FloorAppDatabase.databaseBuilder('app_database.db').build();
//     tagDao = database.tagDao;
//     traitsDao = database.traitDao;

//     final response = await http.get(Uri.parse(link));
//     String son = utf8.decode(GZipCodec().decode(response.bodyBytes));
//     final traitRespone = await http.get(Uri.parse(traitLink));
//     String traitJson = utf8.decode(GZipCodec().decode(traitRespone.bodyBytes));

//     List<dynamic> list = jsonDecode(son);

//     for (int i = 0; i < list.length; i++) {
//       final TagEntity tagEntity = TagEntity(
//           applicable: list[i]["applicable"],
//           cat: list[i]["cat"],
//           description: list[i]["description"],
//           id: list[i]["id"],
//           meta: list[i]["meta"],
//           name: list[i]["name"],
//           parents: list[i]["parents"].length != 0 ? list[i]["parents"][0] : 0,
//           searchable: list[i]["searchable"],
//           vns: list[i]["vns"]);
//       await tagDao.insertTag(tagEntity);
//     }

//     list = jsonDecode(traitJson);

//     for (var i in list) {
//       final TraitEntity traitEntity = TraitEntity(
//           applicable: i['applicable'],
//           description: i['description'],
//           id: i['id'],
//           meta: i['meta'],
//           name: i['name'],
//           parents: i["parents"].length != 0 ? i["parents"][0] : 0,
//           searchable: i['searchable']);
//       await traitsDao.insertTraits(traitEntity);
//     }
//     log("json dump loaded");
//   }

//   // Future<List<TagEntity?>> getTagsEntity(List<int> tags) {
//   //   return tagDao.findTagById(tags);
//   // }

//   // Future<List<TraitEntity?>> getTraitEntity(List<int> traits) {
//   //   return traitsDao.findTraitsById(traits);
//   // }

//   // Future<void> getTagFromLocal() async {
//   //   database =
//   //       await $FloorAppDatabase.databaseBuilder('app_database.db').build();

//   //   final TagEntity tagEntity = TagEntity(
//   //       applicable: false,
//   //       cat: "cat",
//   //       description: "description",
//   //       id: 1,
//   //       meta: true,
//   //       name: "name",
//   //       parents: 2,
//   //       searchable: true,
//   //       vns: 22);

//   //   final TagDao tagDao = database.tagDao;
//   //   await tagDao.insertTag(tagEntity);

//   //   List<TagEntity> result = await tagDao.findAllTags();

//   //   for (int i = 0; i < result.length; i++) {
//   //     log(result[i].id.toString());
//   //   }
//   // }
// }
