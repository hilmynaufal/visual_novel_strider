import 'dart:developer';

import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:visual_novel_strider/controller&repository/abstract_card_persistent_controller.dart';
import 'package:visual_novel_strider/controller&repository/hive_repository_mixin.dart';
import 'package:visual_novel_strider/model/kana_model/individual_result.dart';

import '../model/hive_model/progress_model.dart';

class NotificationController extends AbstractCardPersistentController
    with HiveRepositoryMixin {
  // final Rx<ReceivedAction> action = ReceivedAction().obs;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  StopWatchTimer get stopWatchTimer => _stopWatchTimer;

  // RxInt minutes = 0.obs, seconds = 0.obs;

  // @override
  // void onReady() {
  //   action.bindStream(AwesomeNotifications().actionStream);
  // }

  void listenToScheduleNotification() {}

  void setNotification(String? schedule, String id, String title, String name,
      String icon) async {
    log(schedule.toString());
    // int hour = int.parse(schedule!.split(" ").removeAt(0).split(":").first);
    // int minute = int.parse(schedule.split(" ").removeAt(0).split(":").last);
    // await AwesomeNotifications().createNotification(
    //     schedule: NotificationCalendar(
    //         hour: hour, minute: minute, second: 0, repeats: true),
    //     content: NotificationContent(
    //         largeIcon: icon,
    //         id: int.parse(id.replaceAll("c", "")),
    //         channelKey: 'schedule_notification',
    //         title: title,
    //         body: '$name is waiting for you!',
    //         payload: {'title': title, 'id': id.toString()}));
    // List<PushNotification> list =
    //     await AwesomeNotifications().listScheduledNotifications();
    // log(list.length.toString());
  }

  void cancelReminder(int id) async {
    // await AwesomeNotifications().cancel(id);
  }

  void addToProgressRepository(
      IndividualResult model, String vnID, String title) {
    Duration endTime = Duration(hours: length.value);
    hiveRepository.addToProgress(model, reminder, hexColor.value,
        hasReminder.value, vnID, endTime, note);
    setNotification(reminder, model.id, title, model.name, model.image!.url);
  }

  void clear() {
    reminder = "";
    hasReminder.value = false;
  }

  void setReminderFromButton(bool value, int index, String title) {
    ProgressModel temp = hiveRepository.result[index];
    temp.hasReminder = value;
    temp.save();
    if (value) {
      setNotification(
          hiveRepository.result[index].reminder,
          hiveRepository.result[index].id,
          title,
          hiveRepository.result[index].character!.name,
          hiveRepository.result[index].character!.image!.url);
    } else {
      cancelReminder(
          int.parse(hiveRepository.result[index].id.replaceAll("c", '')));
    }
    update();
  }

  Future<void> addPlayTime(
      String hours, String minutes, ProgressModel progressModel) async {
    String oldTime = progressModel.playtime;
    int oldHours = int.parse(oldTime.removeAllWhitespace.split("hours").first);
    int oldminutes = int.parse(
        oldTime.removeAllWhitespace.split("hours").last.split("minutes").first);

    int newHours = int.parse(hours);
    int newMinutes = int.parse(minutes);

    var oy = Duration(hours: oldHours, minutes: oldminutes);
    var date = DateTime(2021)
        .add(oy)
        .add(Duration(hours: newHours, minutes: newMinutes));

    String playtime = "${date.hour} hours ${date.minute} minutes";

    var lastPlayed = DateTime.now();

    progressModel.playtime = playtime;
    progressModel.lastPlayed = lastPlayed;
    await progressModel.save();

    update();
  }

  Future<void> deleteProgress(ProgressModel progressModel) async {
    await hiveRepository.deleteProgressFromBox(
        progressModel, progressModel.vnId);

    // cancelReminder(
    //     int.parse(hiveRepository.result[index].id.replaceAll("c", '')));
    update();
  }

  void clearData() {
    hexColor.value = 0xFF29b6f6;
    reminder = "";
    hasReminder.value = false;
  }
}
