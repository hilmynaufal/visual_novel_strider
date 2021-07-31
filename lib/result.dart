import 'dart:convert';

import 'package:visual_novel_strider/item.dart';

Result resultFromJson(String str) => Result.fromJson(json.decode(str));

String resultToJson(Result data) => json.encode(data.toJson());

class Result {
  Result({
    required this.items,
    required this.more,
    required this.num,
  });

  List<Item> items;
  bool more;
  int num;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        more: json["more"],
        num: json["num"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "more": more,
        "num": num,
      };
}
