import 'package:hive/hive.dart';
import 'package:visual_novel_strider/model/abstract_card_model.dart';

mixin ReminderMixin on AbstractCardModel {
  @HiveField(3)
  String reminder = '';

  @HiveField(9)
  bool hasReminder = false;
}
