import 'package:hive/hive.dart';

part 'image.g.dart';

@HiveType(typeId: 2)
class Image extends HiveObject {
  @HiveField(0)
  dynamic violence;
  @HiveField(1)
  dynamic sexual;
  @HiveField(2)
  String url;

  Image({
    required this.violence,
    required this.sexual,
    required this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        violence: json["violence"],
        sexual: json["sexual"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "violence": violence,
        "sexual": sexual,
        "url": url,
      };
}
