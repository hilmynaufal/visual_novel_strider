import 'package:hive/hive.dart';
import 'package:visual_novel_strider/model/abstract_card_model.dart';
import 'package:visual_novel_strider/model/kana_model/individual_result.dart';

part 'node_model.g.dart';

@HiveType(typeId: 10)
class EventNodeModel extends AbstractCardModel {
  @HiveField(13)
  String? previousNodeId;
  @HiveField(14)
  String? nextNodeId;
  @HiveField(15)
  String nodeType;

  EventNodeModel(
      {required super.id,
      required super.character,
      required super.playtime,
      required super.lastPlayed,
      required super.hexColor,
      required super.isCompleted,
      required super.endTime,
      required super.isPlaying,
      required super.vnId,
      required super.createdAt,
      required super.note,
      required this.nodeType,
      this.nextNodeId,
      this.previousNodeId});
}
