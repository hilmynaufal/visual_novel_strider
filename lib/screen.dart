import 'image_flagging.dart';

class Screen {
  Screen(
      {required this.image,
      required this.rid,
      required this.nsfw,
      required this.flagging,
      required this.height,
      required this.width});

  String? image;
  int? rid;
  bool? nsfw;
  ImageFlagging? flagging;
  int? height;
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
