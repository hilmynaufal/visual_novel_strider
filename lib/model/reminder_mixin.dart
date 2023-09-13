import 'package:hive/hive.dart';

mixin ReminderMixin {
  @HiveField(3)
  String reminder = '';

  @HiveField(9)
  bool hasReminder = false;
}
