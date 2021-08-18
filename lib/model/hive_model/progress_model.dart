import 'package:hive/hive.dart';
import 'package:visual_novel_strider/model/hive_model/hive_characters_model.dart';

part 'progress_model.g.dart';

@HiveType(typeId: 5)
class ProgressModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int vnId;

  @HiveField(2)
  HiveCHaractersModel? character;

  @HiveField(3)
  String reminder;

  @HiveField(4)
  String playtime;

  @HiveField(5)
  DateTime lastPlayed;

  @HiveField(6)
  int hexColor;

  @HiveField(7)
  bool isCompleted;

  @HiveField(8)
  bool isPlaying;

  @HiveField(9)
  bool hasReminder;

  @HiveField(10)
  String endTime;

  @HiveField(11)
  String note;

  ProgressModel(
      {required this.id,
      required this.character,
      required this.reminder,
      required this.playtime,
      required this.lastPlayed,
      required this.hexColor,
      required this.isCompleted,
      required this.endTime,
      required this.hasReminder,
      required this.isPlaying,
      required this.vnId,
      required this.note});
}
