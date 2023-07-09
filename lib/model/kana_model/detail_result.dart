import 'package:hive/hive.dart';
import 'package:visual_novel_strider/model/kana_model/image.dart';
import 'package:visual_novel_strider/model/kana_model/individual_result.dart';
import 'package:visual_novel_strider/model/kana_model/screenshot_result.dart';
import 'package:visual_novel_strider/model/kana_model/tag_result.dart';

part 'detail_result.g.dart';

@HiveType(typeId: 0)
class DetailResult extends HiveObject {
  @HiveField(1)
  double? rating;
  @HiveField(2)
  String? description;
  @HiveField(3)
  double? popularity;
  @HiveField(4)
  List<Screenshot>? screenshots;
  @HiveField(5)
  Image? image;
  @HiveField(6)
  String? id;
  @HiveField(7)
  List<TagResult> tags;
  @HiveField(8)
  List<String>? languages;
  @HiveField(9)
  dynamic alttitle;
  @HiveField(10)
  String title;
  @HiveField(11)
  String? released;
  @HiveField(12)
  int? votecount;
  @HiveField(13)
  String? olang;
  @HiveField(14)
  int? length;
  @HiveField(19)
  List<IndividualResult>? characters;
  @HiveField(20)
  bool? isComplete;

  DetailResult(
      {this.rating,
      this.description,
      this.popularity,
      this.screenshots,
      this.image,
      this.id,
      required this.tags,
      this.languages,
      this.alttitle,
      required this.title,
      this.released,
      this.votecount,
      this.olang,
      this.length});

  factory DetailResult.fromJson(Map<String, dynamic> json) => DetailResult(
      rating: json["rating"]?.toDouble(),
      description: json["description"],
      popularity: json["popularity"]?.toDouble(),
      screenshots: json["screenshots"] == null
          ? []
          : List<Screenshot>.from(
              json["screenshots"]!.map((x) => Screenshot.fromJson(x))),
      image: json["image"] == null ? null : Image.fromJson(json["image"]),
      id: json["id"],
      tags: json["tags"] == null
          ? []
          : List<TagResult>.from(
              json["tags"]!.map((x) => TagResult.fromJson(x))),
      languages: json["languages"] == null
          ? []
          : List<String>.from(json["languages"]!.map((x) => x)),
      alttitle: json["alttitle"],
      title: json["title"],
      released: json["released"],
      votecount: json["votecount"],
      olang: json["olang"],
      length: json["length"]);

  Map<String, dynamic> toJson() => {
        "rating": rating,
        "description": description,
        "popularity": popularity,
        "screenshots": screenshots == null
            ? []
            : List<dynamic>.from(screenshots!.map((x) => x.toJson())),
        "image": image?.toJson(),
        "id": id,
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "languages": languages == null
            ? []
            : List<dynamic>.from(languages!.map((x) => x)),
        "alttitle": alttitle,
        "title": title,
        "released": released,
        "votecount": votecount,
        "olang": olang,
        "length": length
      };
}
