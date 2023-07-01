import 'package:visual_novel_strider/model/release_item.dart';

class ReleaseResult {
  ReleaseResult({
    required this.num,
    required this.more,
    required this.items,
  });

  int num;
  bool more;
  List<ReleaseItem>? items;

  factory ReleaseResult.fromJson(Map<String, dynamic> json) => ReleaseResult(
        num: json["num"],
        more: json["more"],
        items: List<ReleaseItem>.from(
            json["items"].map((x) => ReleaseItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "num": num,
        "more": more,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}
