import 'package:visual_novel_strider/model/old_socket_model/image_flagging.dart';

import 'gender.dart';

class CharaItem {
  CharaItem(
      {required this.spoilGender,
      required this.gender,
      required this.id,
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

  dynamic spoilGender;
  Gender? gender;
  int? id;
  String? original;
  String? name;
  String? bloodt;
  List<dynamic>? birthday;
  String? aliases;
  String? description;
  int? age;
  String? image;
  ImageFlagging? imageFlagging;
  List<List<dynamic>> vns;
  List<List<dynamic>> traits;

  factory CharaItem.fromJson(Map<String, dynamic> json) => CharaItem(
      age: json["age"],
      aliases: json["aliases"],
      description: json["description"],
      image: json["image"],
      traits: List<List<dynamic>>.from(
          json["traits"].map((x) => List<dynamic>.from(x.map((x) => x)))),
      imageFlagging: json["image_flagging"] == null
          ? null
          : ImageFlagging.fromJson(json["image_flagging"]),
      spoilGender: json["spoil_gender"],
      gender: json["gender"] == null ? null : genderValues.map![json["gender"]],
      id: json["id"],
      original: json["original"],
      name: json["name"],
      bloodt: json["bloodt"],
      birthday: List<dynamic>.from(json["birthday"].map((x) => x)),
      vns: List<List<dynamic>>.from(
          json["vns"].map((x) => List<dynamic>.from(x.map((x) => x)))));

  Map<String, dynamic> toJson() => {
        "spoil_gender": spoilGender,
        "gender": gender == null ? null : genderValues.reverse![gender],
        "id": id,
        "original": original,
        "name": name,
        "bloodt": bloodt,
        "birthday": List<dynamic>.from(birthday!.map((x) => x)),
      };
}
