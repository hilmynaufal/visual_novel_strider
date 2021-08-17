import 'package:floor/floor.dart';

@Entity(tableName: "traits")
class TraitEntity {
  @PrimaryKey(autoGenerate: false)
  int id;

  bool applicable;

  String description;
  bool meta;
  String name;
  int parents;
  bool searchable;

  TraitEntity(
      {required this.applicable,
      required this.description,
      required this.id,
      required this.meta,
      required this.name,
      required this.parents,
      required this.searchable});
}
