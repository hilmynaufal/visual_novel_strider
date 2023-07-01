import 'package:visual_novel_strider/model/old_socket_model/producer.dart';

import 'media.dart';

class ReleaseItem {
  ReleaseItem({
    required this.voiced,
    required this.languages,
    required this.type,
    required this.original,
    required this.doujin,
    required this.producers,
    required this.website,
    required this.patch,
    required this.minage,
    required this.released,
    required this.id,
    required this.notes,
    required this.media,
    required this.gtin,
    required this.animation,
    required this.resolution,
    required this.platforms,
    required this.catalog,
    required this.title,
    required this.freeware,
  });

  int? voiced;
  List<String>? languages;
  String? type;
  String? original;
  bool? doujin;
  List<Producer>? producers;
  String? website;
  bool? patch;
  int? minage;
  DateTime? released;
  int? id;
  String? notes;
  List<Media>? media;
  String? gtin;
  List<dynamic>? animation;
  String? resolution;
  List<String>? platforms;
  String? catalog;
  String? title;
  bool? freeware;

  factory ReleaseItem.fromJson(Map<String, dynamic> json) => ReleaseItem(
        voiced: json["voiced"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        type: json["type"],
        original: json["original"],
        doujin: json["doujin"],
        producers: List<Producer>.from(
            json["producers"].map((x) => Producer.fromJson(x))),
        website: json["website"],
        patch: json["patch"],
        minage: json["minage"],
        released: DateTime.parse(json["released"]),
        id: json["id"],
        notes: json["notes"],
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
        gtin: json["gtin"],
        animation: List<dynamic>.from(json["animation"].map((x) => x)),
        resolution: json["resolution"],
        platforms: List<String>.from(json["platforms"].map((x) => x)),
        catalog: json["catalog"],
        title: json["title"],
        freeware: json["freeware"],
      );

  Map<String, dynamic> toJson() => {
        "voiced": voiced,
        "languages": List<dynamic>.from(languages!.map((x) => x)),
        "type": type,
        "original": original,
        "doujin": doujin,
        "producers": List<dynamic>.from(producers!.map((x) => x.toJson())),
        "website": website,
        "patch": patch,
        "minage": minage,
        "released":
            "${released!.year.toString().padLeft(4, '0')}-${released!.month.toString().padLeft(2, '0')}-${released!.day.toString().padLeft(2, '0')}",
        "id": id,
        "notes": notes,
        "media": List<dynamic>.from(media!.map((x) => x.toJson())),
        "gtin": gtin,
        "animation": List<dynamic>.from(animation!.map((x) => x)),
        "resolution": resolution,
        "platforms": List<dynamic>.from(platforms!.map((x) => x)),
        "catalog": catalog,
        "title": title,
        "freeware": freeware,
      };
}
