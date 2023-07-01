import 'package:visual_novel_strider/model/kana_model/image.dart';

class Result {
  String title;
  String? olang;
  List<String> languages;
  Image image;
  String id;
  String released;
  String? alttitle;
  double? rating;

  Result({
    required this.title,
    required this.olang,
    required this.languages,
    required this.image,
    required this.id,
    required this.released,
    required this.alttitle,
    required this.rating,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        title: json["title"],
        olang: json["olang"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        image: Image.fromJson(json["image"]),
        id: json["id"],
        released: json["released"],
        alttitle: json["alttitle"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "olang": olang,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "image": image.toJson(),
        "id": id,
        "released": released,
        "alttitle": alttitle,
        "rating": rating,
      };
}
