import 'package:hive/hive.dart';

part 'image_flagging.g.dart';

@HiveType(typeId: 3)
class ImageFlagging extends HiveObject {
  ImageFlagging({
    required this.votecount,
    required this.sexualAvg,
    required this.violenceAvg,
  });

  @HiveField(0)
  dynamic votecount;

  @HiveField(1)
  dynamic sexualAvg;

  @HiveField(2)
  dynamic violenceAvg;

  factory ImageFlagging.fromJson(Map<String, dynamic> json) => ImageFlagging(
        votecount: json["votecount"],
        sexualAvg: json["sexual_avg"],
        violenceAvg: json["violence_avg"],
      );

  Map<String, dynamic> toJson() => {
        "votecount": votecount,
        "sexual_avg": sexualAvg,
        "violence_avg": violenceAvg,
      };
}
