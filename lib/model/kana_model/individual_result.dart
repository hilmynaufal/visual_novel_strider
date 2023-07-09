import 'package:hive/hive.dart';
import 'package:visual_novel_strider/model/kana_model/image.dart';
import 'package:visual_novel_strider/model/kana_model/trait.dart';
import 'package:visual_novel_strider/model/kana_model/vns.dart';

part 'individual_result.g.dart';

@HiveType(typeId: 1)
class IndividualResult extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  List<Trait> traits;

  @HiveField(2)
  List<String>? sex;

  @HiveField(3)
  List<Vns> vns;

  @HiveField(4)
  Image? image;

  @HiveField(5)
  List<int>? birthday;

  @HiveField(6)
  String name;

  @HiveField(7)
  String? description;

  @HiveField(8)
  int? age;

  @HiveField(9)
  String? original;

  IndividualResult({
    required this.traits,
    required this.id,
    this.sex,
    required this.vns,
    this.image,
    this.birthday,
    required this.name,
    this.description,
    this.age,
    this.original,
  });

  factory IndividualResult.fromJson(Map<String, dynamic> json) =>
      IndividualResult(
        traits: json["traits"] == null
            ? []
            : List<Trait>.from(json["traits"]!.map((x) => Trait.fromJson(x))),
        id: json["id"],
        sex: json["sex"] == null
            ? []
            : List<String>.from(json["sex"]!.map((x) => x)),
        vns: json["vns"] == null
            ? []
            : List<Vns>.from(json["vns"]!.map((x) => Vns.fromJson(x))),
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
        birthday: json["birthday"] == null
            ? []
            : List<int>.from(json["birthday"]!.map((x) => x)),
        name: json["name"],
        description: json["description"],
        age: json["age"],
        original: json["original"],
      );

  Map<String, dynamic> toJson() => {
        "traits": List<dynamic>.from(traits.map((x) => x.toJson())),
        "id": id,
        "sex": sex == null ? [] : List<dynamic>.from(sex!.map((x) => x)),
        "vns": List<dynamic>.from(vns.map((x) => x.toJson())),
        "image": image?.toJson(),
        "birthday":
            birthday == null ? [] : List<dynamic>.from(birthday!.map((x) => x)),
        "name": name,
        "description": description,
        "age": age,
        "original": original,
      };
}
