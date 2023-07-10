import 'package:hive/hive.dart';

part 'trait.g.dart';

@HiveType(typeId: 7)
class Trait extends HiveObject {
  @HiveField(0)
  String groupName;
  @HiveField(1)
  String name;
  @HiveField(2)
  String id;
  @HiveField(3)
  String? description;

  Trait(
      {required this.groupName,
      required this.name,
      required this.id,
      this.description});

  factory Trait.fromJson(Map<String, dynamic> json) => Trait(
      groupName: json["group_name"],
      name: json["name"],
      id: json["id"],
      description: json["description"]);

  Map<String, dynamic> toJson() => {
        "group_name": groupName,
        "name": name,
        "id": id,
        "description": description
      };
}
