import 'package:hive/hive.dart';

import 'image_flagging.dart';

part 'screen.g.dart';

@HiveType(typeId: 4)
class Screen extends HiveObject {
  Screen(
      {required this.image,
      required this.rid,
      required this.nsfw,
      required this.flagging,
      required this.height,
      required this.width});

  @HiveField(0)
  String? image;

  @HiveField(1)
  int? rid;

  @HiveField(2)
  bool? nsfw;

  @HiveField(3)
  ImageFlagging? flagging;

  @HiveField(4)
  int? height;

  @HiveField(5)
  int? width;

  factory Screen.fromJson(Map<String, dynamic> json) => Screen(
        nsfw: json["nsfw"],
        width: json["width"],
        rid: json["rid"],
        height: json["height"],
        flagging: ImageFlagging.fromJson(json["flagging"]),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "nsfw": nsfw,
        "width": width,
        "rid": rid,
        "height": height,
        "flagging": flagging!.toJson(),
        "image": image,
      };
}
