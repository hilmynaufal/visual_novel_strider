// ignore_for_file: unused_import

import 'package:hive/hive.dart';

import '../old_socket_model/image_flagging.dart';

part 'hive_characters_model.g.dart';

// @HiveType(typeId: 1)
class HiveCHaractersModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  dynamic spoilGender;

  @HiveField(3)
  String? gender;

  @HiveField(4)
  String? original;

  @HiveField(5)
  String? bloodt;

  @HiveField(6)
  List<dynamic>? birthday;

  @HiveField(7)
  String? aliases;

  @HiveField(8)
  String? description;

  @HiveField(9)
  int? age;

  @HiveField(10)
  String? image;

  @HiveField(11)
  ImageFlagging? imageFlagging;

  @HiveField(12)
  List<List<dynamic>> vns;

  @HiveField(13)
  List<List<dynamic>> traits;

  HiveCHaractersModel(
      {required this.id,
      required this.spoilGender,
      required this.gender,
      required this.original,
      required this.name,
      required this.bloodt,
      required this.birthday,
      required this.imageFlagging,
      required this.image,
      required this.aliases,
      required this.description,
      required this.age,
      required this.vns,
      required this.traits});
}
