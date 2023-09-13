import 'package:hive/hive.dart';
import 'package:visual_novel_strider/model/abstract_card_model.dart';
import 'package:visual_novel_strider/model/hive_model/hive_characters_model.dart';
import 'package:visual_novel_strider/model/reminder_mixin.dart';

import '../kana_model/individual_result.dart';

part 'progress_model.g.dart';

@HiveType(typeId: 9)
class ProgressModel extends AbstractCardModel
    with ReminderMixin, HiveObjectMixin {
  ProgressModel(
      {required String id,
      required IndividualResult? character,
      required String reminder,
      required String playtime,
      required DateTime lastPlayed,
      required int hexColor,
      required bool isCompleted,
      required String endTime,
      required bool hasReminder,
      required bool isPlaying,
      required String vnId,
      required String note})
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
            note: note) {
    this.reminder = reminder;
    this.hasReminder = hasReminder;
  }
}
