import 'package:hive/hive.dart';
import 'package:visual_novel_strider/model/abstract_card_model.dart';
import 'package:visual_novel_strider/model/kana_model/individual_result.dart';

part 'node_model.g.dart';

@HiveType(typeId: 10)
class NodeModel extends AbstractCardModel {
  @HiveField(12)
  String? previousNodeId;
  @HiveField(13)
  String? nextNodeId;

  NodeModel(
      {required String id,
      required IndividualResult? character,
      required String playtime,
      required DateTime lastPlayed,
      required int hexColor,
      required bool isCompleted,
      required String endTime,
      required bool isPlaying,
      required String vnId,
      required String note,
      this.nextNodeId,
      this.previousNodeId})
      : super(
            id: id,
            character: character,
            playtime: playtime,
            lastPlayed: lastPlayed,
            hexColor: hexColor,
            isCompleted: isCompleted,
            endTime: endTime,
            isPlaying: isPlaying,
            vnId: vnId,
            note: note);
}
