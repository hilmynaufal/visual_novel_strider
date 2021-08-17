import 'package:hive/hive.dart';

part 'links.g.dart';

@HiveType(typeId: 2)
class Links extends HiveObject {
  Links({
    required this.encubed,
    required this.renai,
    required this.wikipedia,
    required this.wikidata,
  });

  @HiveField(0)
  dynamic encubed;

  @HiveField(1)
  dynamic renai;

  @HiveField(2)
  String? wikipedia;

  @HiveField(3)
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
