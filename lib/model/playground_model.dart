import 'package:hive/hive.dart';
import 'package:visual_novel_strider/model/kana_model/branch_node_model.dart';
import 'package:visual_novel_strider/model/kana_model/node_model.dart';

part 'playground_model.g.dart';

@HiveType(typeId: 12)
class PlaygroundModel with HiveObjectMixin {
  @HiveField(0)
  String id;

  @HiveField(1)
  String vnId;

  @HiveField(2)
  String name;

  @HiveField(3)
  String createdAt;

  @HiveField(4)
  String lastPlayed;

  @HiveField(5)
  bool isFinished;

  @HiveField(6)
  String route;

  @HiveField(7)
  List<EventNodeModel> eventNodes;

  @HiveField(8)
  List<BranchNodeModel> branchNodes;

  PlaygroundModel(
      {required this.id,
      required this.vnId,
      required this.eventNodes,
      required this.name,
      required this.createdAt,
      required this.isFinished,
      required this.route,
      required this.lastPlayed,
      required this.branchNodes});
}
