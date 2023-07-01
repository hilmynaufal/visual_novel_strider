import 'package:hive/hive.dart';

@HiveType(typeId: 6)
class Vns {
  @HiveField(1)
  String? id;
  @HiveField(2)
  int? spoiler;
  @HiveField(3)
  String? role;

  Vns({
    this.id,
    this.spoiler,
    this.role,
  });

  factory Vns.fromJson(Map<String, dynamic> json) => Vns(
        id: json["id"],
        spoiler: json["spoiler"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "spoiler": spoiler,
        "role": role,
      };
}
