import 'package:hive/hive.dart';
import 'package:visual_novel_strider/model/kana_model/image.dart';
import 'package:visual_novel_strider/model/kana_model/vns.dart';

// @HiveType(typeId: 1)
// class CharactersResult {
//   @HiveField(1)
//   String name;
//   @HiveField(2)
//   String? description;
//   @HiveField(3)
//   String id;
//   @HiveField(4)
//   Image? image;
//   @HiveField(5)
//   int? age;
//   @HiveField(6)
//   List<Vns>? vns;
//   @HiveField(7)
//   List<String>? sex;

//   CharactersResult({
//     required this.name,
//     this.description,
//     required this.id,
//     this.image,
//     this.age,
//     this.vns,
//     this.sex,
//   });

//   factory CharactersResult.fromJson(Map<String, dynamic> json) =>
//       CharactersResult(
//         name: json["name"],
//         description: json["description"],
//         id: json["id"],
//         image: json["image"] == null ? null : Image.fromJson(json["image"]),
//         age: json["age"],
//         vns: json["vns"] == null
//             ? []
//             : List<Vns>.from(json["vns"]!.map((x) => Vns.fromJson(x))),
//         sex: json["sex"] == null
//             ? []
//             : List<String>.from(json["sex"]!.map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "description": description,
//         "id": id,
//         "image": image?.toJson(),
//         "age": age,
//         "vns":
//             vns == null ? [] : List<dynamic>.from(vns!.map((x) => x.toJson())),
//         "sex": sex == null ? [] : List<dynamic>.from(sex!.map((x) => x)),
//       };
// }
