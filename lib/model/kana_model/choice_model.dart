import 'package:hive/hive.dart';
import 'package:visual_novel_strider/model/kana_model/individual_result.dart';

part 'choice_model.g.dart';

@HiveType(typeId: 14)
class ChoiceModel extends HiveObject {
  @HiveField(1)
  String id;

  @HiveField(2)
  IndividualResult character;

  @HiveField(3)
  String choiceOrig;

  @HiveField(4)
  String choiceTrans;

  @HiveField(5)
  String isSelected;

  @HiveField(6)
  int hexColor;

  @HiveField(7)
  String? nextNodeId;

  ChoiceModel(
      {required this.id,
      required this.character,
      required this.choiceOrig,
      required this.choiceTrans,
      required this.isSelected,
      required this.hexColor,
      this.nextNodeId});
}
