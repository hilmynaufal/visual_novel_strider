class Image {
  dynamic violence;
  dynamic sexual;
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
