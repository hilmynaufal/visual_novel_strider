import 'package:visual_novel_strider/model/old_socket_model/links.dart';
import 'package:visual_novel_strider/model/old_socket_model/screen.dart';

import 'image_flagging.dart';

class Item {
  Item(
      {required this.aliases,
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
      required this.id,
      required this.origLang,
      required this.released,
      required this.languages,
      required this.imageFlagging,
      required this.image,
      required this.length,
      required this.screens});

  String? aliases;
  double? popularity;
  bool? imageNsfw;
  Links? links;
  double? rating;
  List<String>? platforms;
  dynamic original;
  List<List<double>>? tags;
  String? description;
  int? votecount;
  String title;
  int id;
  List<String>? origLang;
  String? released;
  List<String>? languages;
  ImageFlagging? imageFlagging;
  String? image;
  int? length;
  List<Screen>? screens;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        screens:
            List<Screen>.from(json["screens"].map((x) => Screen.fromJson(x))),
        aliases: json["aliases"],
        popularity: json["popularity"].toDouble(),
        imageNsfw: json["image_nsfw"],
        links: Links.fromJson(json["links"]),
        rating: json["rating"].toDouble(),
        platforms: List<String>.from(json["platforms"].map((x) => x)),
        original: json["original"],
        tags: List<List<double>>.from(json["tags"]
            .map((x) => List<double>.from(x.map((x) => x.toDouble())))),
        description: json["description"],
        votecount: json["votecount"],
        title: json["title"],
        id: json["id"],
        origLang: List<String>.from(json["orig_lang"].map((x) => x)),
        released: json["released"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        imageFlagging: ImageFlagging.fromJson(json["image_flagging"]),
        image: json["image"],
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "aliases": aliases,
        "popularity": popularity,
        "image_nsfw": imageNsfw,
        "links": links!.toJson(),
        "rating": rating,
        "platforms": List<dynamic>.from(platforms!.map((x) => x)),
        "original": original,
        "tags": List<dynamic>.from(
            tags!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "description": description,
        "votecount": votecount,
        "title": title,
        "id": id,
        "orig_lang": List<dynamic>.from(origLang!.map((x) => x)),
        "released": released,
        "languages": List<dynamic>.from(languages!.map((x) => x)),
        "image_flagging": imageFlagging!.toJson(),
        "image": image,
        "length": length,
      };
}
