class ImageFlagging {
  ImageFlagging({
    required this.votecount,
    required this.sexualAvg,
    required this.violenceAvg,
  });

  dynamic votecount;
  dynamic sexualAvg;
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
