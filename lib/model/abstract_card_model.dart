import 'package:hive/hive.dart';

import 'kana_model/individual_result.dart';

abstract class AbstractCardModel {
  @HiveField(0)
  String id;

  @HiveField(1)
  String vnId;

  @HiveField(2)
  IndividualResult? character;

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

  @HiveField(10)
  String endTime;

  @HiveField(11)
  String note;

  AbstractCardModel(
      {required this.id,
      required this.character,
      required this.playtime,
      required this.lastPlayed,
      required this.hexColor,
      required this.isCompleted,
      required this.endTime,
      required this.isPlaying,
      required this.vnId,
      required this.note});
}
