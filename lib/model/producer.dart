class Producer {
  Producer({
    required this.publisher,
    required this.developer,
    required this.type,
    required this.original,
    required this.name,
    required this.id,
  });

  bool publisher;
  bool developer;
  String type;
  String? original;
  String name;
  int id;

  factory Producer.fromJson(Map<String, dynamic> json) => Producer(
        publisher: json["publisher"],
        developer: json["developer"],
        type: json["type"],
        original: json["original"],
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "publisher": publisher,
        "developer": developer,
        "type": type,
        "original": original,
        "name": name,
        "id": id,
      };
}
