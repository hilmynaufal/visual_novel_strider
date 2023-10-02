import 'package:hive/hive.dart';
import 'package:visual_novel_strider/model/abstract_card_model.dart';
import 'package:visual_novel_strider/model/reminder_mixin.dart';

import '../kana_model/individual_result.dart';

part 'progress_model.g.dart';

@HiveType(typeId: 9)
class ProgressModel extends AbstractCardModel
    with ReminderMixin, HiveObjectMixin {
  ProgressModel(
      {required super.id,
      required super.character,
      required String reminder,
      required super.playtime,
      required super.lastPlayed,
      required super.hexColor,
      required super.isCompleted,
      required super.endTime,
      required bool hasReminder,
      required super.isPlaying,
      required super.vnId,
      required super.createdAt,
      required super.note}) {
    this.reminder = reminder;
    this.hasReminder = hasReminder;
  }
}
