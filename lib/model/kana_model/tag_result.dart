import 'package:hive/hive.dart';

@HiveType(typeId: 5)
class TagResult {
  @HiveField(1)
  int spoiler;
  @HiveField(2)
  double rating;
  @HiveField(3)
  String name;
  @HiveField(4)
  String id;

  TagResult({
    required this.spoiler,
    required this.rating,
    required this.name,
    required this.id,
  });

  factory TagResult.fromJson(Map<String, dynamic> json) => TagResult(
        spoiler: json["spoiler"],
        rating: json["rating"]?.toDouble(),
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "spoiler": spoiler,
        "rating": rating,
        "name": name,
        "id": id,
      };
}
