import 'package:hive/hive.dart';

part 'developer_model.g.dart';

@HiveType(typeId: 11)
class DeveloperModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;

  DeveloperModel({required this.id, required this.name});

  factory DeveloperModel.fromJson(Map<String, dynamic> json) => DeveloperModel(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
