import 'package:hive/hive.dart';

import 'choice_model.dart';

part 'branch_node_model.g.dart';

@HiveType(typeId: 13)
class BranchNodeModel extends HiveObject {
  @HiveField(1)
  String id;

  @HiveField(2)
  String vnid;

  @HiveField(3)
  String createdAt;

  @HiveField(4)
  String nodeType;

  @HiveField(5)
  bool hasSelected;

  @HiveField(6)
  String? choiceSelectedId;

  @HiveField(7)
  List<ChoiceModel> choices;

  BranchNodeModel(
      {required this.id,
      required this.createdAt,
      this.choiceSelectedId,
      required this.hasSelected,
      required this.vnid,
      required this.choices,
      required this.nodeType});
}
