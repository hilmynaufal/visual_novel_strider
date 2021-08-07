class TagsResult {
  TagsResult({
    required this.aliases,
    required this.applicable,
    required this.cat,
    required this.description,
    required this.id,
    required this.meta,
    required this.name,
    required this.parents,
    required this.searchable,
    required this.vns,
  });

  List<String>? aliases;
  bool? applicable;
  String? cat;
  String? description;
  int id;
  bool? meta;
  String? name;
  List<dynamic>? parents;
  bool? searchable;
  int? vns;

  factory TagsResult.fromJson(Map<String, dynamic> json) => TagsResult(
        aliases: List<String>.from(json["aliases"].map((x) => x)),
        applicable: json["applicable"],
        cat: json["cat"],
        description: json["description"],
        id: json["id"],
        meta: json["meta"],
        name: json["name"],
        parents: List<dynamic>.from(json["parents"].map((x) => x)),
        searchable: json["searchable"],
        vns: json["vns"],
      );

  Map<String, dynamic> toJson() => {
        "aliases": List<dynamic>.from(aliases!.map((x) => x)),
        "applicable": applicable,
        "cat": cat,
        "description": description,
        "id": id,
        "meta": meta,
        "name": name,
        "parents": List<dynamic>.from(parents!.map((x) => x)),
        "searchable": searchable,
        "vns": vns,
      };
}
