import 'package:hive/hive.dart';
import 'package:visual_novel_strider/model/hive_model/hive_characters_model.dart';

import '../../links.dart';
import '../image_flagging.dart';
import '../screen.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 0)
class HiveVNModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? aliases;

  @HiveField(3)
  double? popularity;

  @HiveField(4)
  bool? imageNsfw;

  @HiveField(5)
  Links? links;

  @HiveField(6)
  double? rating;

  @HiveField(7)
  List<String>? platforms;

  @HiveField(8)
  dynamic? original;

  @HiveField(9)
  List<List<double>>? tags;

  @HiveField(10)
  String? description;

  @HiveField(11)
  int? votecount;

  @HiveField(12)
  List<String>? origLang;

  @HiveField(13)
  String? released;

  @HiveField(14)
  List<String>? languages;

  @HiveField(15)
  ImageFlagging? imageFlagging;

  @HiveField(16)
  String? image;

  @HiveField(17)
  int? length;

  @HiveField(18)
  List<Screen>? screens;

  @HiveField(19)
  List<HiveCHaractersModel>? characters;

  HiveVNModel(
      {required this.id,
      required this.aliases,
      required this.popularity,
      required this.imageNsfw,
      required this.links,
      required this.rating,
      required this.platforms,
      required this.original,
      required this.tags,
      required this.description,
      required this.votecount,
      required this.title,
      required this.origLang,
      required this.released,
      required this.languages,
      required this.imageFlagging,
      required this.image,
      required this.length,
      required this.screens});
}
