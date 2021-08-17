import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:visual_novel_strider/controller&repository/hive_repository.dart';
import 'package:visual_novel_strider/model/hive_model/hive_characters_model.dart';

import '../model/hive_model/progress_model.dart';

class NotificationController extends GetxController {
  final Rx<ReceivedAction> action = ReceivedAction().obs;

  final HiveRepository hiveRepository = Get.find();

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  StopWatchTimer get stopWatchTimer => _stopWatchTimer;

  // RxInt minutes = 0.obs, seconds = 0.obs;
  RxBool isPlaying = false.obs;

  RxInt hexColor = 0xFF29b6f6.obs;
  String reminder = "";
  RxBool hasReminder = false.obs;
  RxInt length = 1.obs;
  String note = "";

  Map<int, int> hairColor = {
    0: 0xFF,
    8: 0xFFEAAEAE,
    7: 0xFF29b6f6,
    956: Colors.grey.shade400.value,
    6: 0xFF8D5F51,
    1305: Colors.orange.shade300.value,
    10: 0xffB94E5C,
    9: 0xFFBF6BA6,
    4: 0xFF393B52,
    50: 0xFFB1BA92,
    919: Colors.cyan.shade400.value,
    926: Colors.teal.shade300.value,
    5: 0xFFFBDEB7,
    11: 0xFF
  };

  Map<int, int> eyeColor = {
    0: 0xFF,
    110: 0xFF29b6f6,
    53: 0xFF8D5F51,
    113: 0xffa8b461,
    727: 0xFFEAAEAE,
    112: 0xFFB1BA92,
    927: Colors.teal.shade300.value,
    114: 0xFFBF6BA6,
    115: 0xffB94E5C,
    906: 0xff9A2A2A,
    108: Colors.amber.shade900.withOpacity(0.5).value,
    109: 0xFF393B52,
    111: Colors.grey.shade400.value,
    921: Colors.cyan.shade400.value,
  };

  // @override
  // void onReady() {
  //   action.bindStream(AwesomeNotifications().actionStream);
  // }

  void listenToScheduleNotification() {}

  void setNotification(
      String? schedule, int id, String title, String name, String icon) async {
    log(schedule.toString());
    int hour = int.parse(schedule!.split(" ").removeAt(0).split(":").first);
    int minute = int.parse(schedule.split(" ").removeAt(0).split(":").last);
    await AwesomeNotifications().createNotification(
        schedule: NotificationCalendar(
            hour: hour, minute: minute, second: 0, repeats: true),
        content: NotificationContent(
            largeIcon: icon,
            id: id,
            channelKey: 'schedule_notification',
            title: title,
            body: '$name is waiting for you!',
            payload: {'title': title, 'id': id.toString()}));
    List<PushNotification> list =
        await AwesomeNotifications().listScheduledNotifications();
    log(list.length.toString());
  }

  void cancelReminder(int id) async {
    await AwesomeNotifications().cancel(id);
  }

  void addToProgressRepository(
      HiveCHaractersModel model, int vnID, String title) {
    Duration _endTime = Duration(hours: length.value);
    hiveRepository.addToProgress(
        model,
        reminder,
        hexColor.value == 0xFF ? 0xFF29b6f6 : hexColor.value,
        hasReminder.value,
        vnID,
        _endTime,
        note);
    setNotification(reminder, model.id, title, model.name!, model.image!);
  }

  void clear() {
    reminder = "";
    hasReminder.value = false;
  }

  void setReminderFromButton(bool value, int index, String title) {
    ProgressModel _temp = hiveRepository.result[index];
    _temp.hasReminder = value;
    _temp.save();
    if (value) {
      setNotification(
          hiveRepository.result[index].reminder,
          hiveRepository.result[index].id,
          title,
          hiveRepository.result[index].character!.name!,
          hiveRepository.result[index].character!.image!);
    } else {
      cancelReminder(hiveRepository.result[index].id);
    }
    update();
  }

  Future<void> addPlayTime(String hours, String minutes, int index) async {
    String oldTime = hiveRepository.result[index].playtime;
    int oldHours = int.parse(oldTime.removeAllWhitespace.split("hours").first);
    int oldminutes = int.parse(
        oldTime.removeAllWhitespace.split("hours").last.split("minutes").first);

    int newHours = int.parse(hours);
    int newMinutes = int.parse(minutes);

    var oy = Duration(hours: oldHours, minutes: oldminutes);
    var date = DateTime(2021)
        .add(oy)
        .add(Duration(hours: newHours, minutes: newMinutes));

    String playtime =
        date.hour.toString() + " hours " + date.minute.toString() + " minutes";

    var lastPlayed = DateTime.now();

    ProgressModel _temp = hiveRepository.result[index];

    _temp.playtime = playtime;
    _temp.lastPlayed = lastPlayed;
    await _temp.save();

    update();
  }

  Future<void> deleteProgress(int index, int vnID) async {
    await hiveRepository.deleteProgressFromBox(index, vnID);
    cancelReminder(hiveRepository.result[index].id);
    update();
  }

  void clearData() {
    hexColor.value = 0xFF29b6f6;
    reminder = "";
    hasReminder.value = false;
  }
}
