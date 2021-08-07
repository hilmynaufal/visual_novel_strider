import 'package:floor/floor.dart';

@Entity(tableName: "tags")
class TagEntity {
  @PrimaryKey(autoGenerate: false)
  int? id;

  bool applicable;
  String cat;

  String description;
  bool meta;
  String name;
  int? parents;
  bool searchable;
  int vns;

  TagEntity({
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
}
