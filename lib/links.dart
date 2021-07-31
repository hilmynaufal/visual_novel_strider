class Links {
  Links({
    required this.encubed,
    required this.renai,
    required this.wikipedia,
    required this.wikidata,
  });

  dynamic encubed;
  dynamic renai;
  String? wikipedia;
  String? wikidata;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        encubed: json["encubed"],
        renai: json["renai"],
        wikipedia: json["wikipedia"],
        wikidata: json["wikidata"],
      );

  Map<String, dynamic> toJson() => {
        "encubed": encubed,
        "renai": renai,
        "wikipedia": wikipedia,
        "wikidata": wikidata,
      };
}
