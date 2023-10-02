class ReleaseResult {
  List<String> media;
  bool? patch;
  String title;
  String released;
  int? minage;
  List<String> languages;
  int? voiced;
  List<String> platforms;
  List<String> rtype;
  bool? uncensored;
  String id;
  bool official;
  List<String> producers;

  ReleaseResult({
    required this.media,
    required this.patch,
    required this.title,
    required this.released,
    this.minage,
    required this.languages,
    this.voiced,
    required this.platforms,
    required this.rtype,
    this.uncensored,
    required this.id,
    required this.official,
    required this.producers,
  });

  factory ReleaseResult.fromJson(Map<String, dynamic> json) => ReleaseResult(
        media: List<String>.from(json["media"].map((x) => x["medium"])),
        patch: json["patch"],
        title: json["title"],
        released: json["released"],
        minage: json["minage"],
        languages: List<String>.from(json["languages"].map((x) => x["lang"])),
        voiced: json["voiced"],
        platforms: List<String>.from(json["platforms"].map((x) => x)),
        rtype: List<String>.from(json["vns"].map((x) => x["rtype"])),
        uncensored: json["uncensored"],
        id: json["id"],
        official: json["official"],
        producers: List<String>.from(json["producers"].map((x) => x["name"])),
      );

  // Map<String, dynamic> toJson() => {
  //     "media": List<dynamic>.from(media.map((x) => x.toMap())),
  //     "patch": patch,
  //     "title": title,
  //     "released": released,
  //     "minage": minage,
  //     "languages": List<dynamic>.from(languages.map((x) => x.toMap())),
  //     "voiced": voiced,
  //     "platforms": List<dynamic>.from(platforms.map((x) => x)),
  //     "vns": List<dynamic>.from(vns.map((x) => x.toMap())),
  //     "uncensored": uncensored,
  //     "id": id,
  //     "official": official,
  //     "producers": List<dynamic>.from(producers.map((x) => x.toMap())),
  // };
}
