import 'package:hive/hive.dart';

part 'screenshot_result.g.dart';

@HiveType(typeId: 4)
class Screenshot {
  @HiveField(1)
  String? url;

  Screenshot({
    this.url,
  });

  factory Screenshot.fromJson(Map<String, dynamic> json) => Screenshot(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
