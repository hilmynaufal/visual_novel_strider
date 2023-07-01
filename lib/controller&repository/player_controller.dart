import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:visual_novel_strider/controller&repository/hive_repository.dart';
import 'package:visual_novel_strider/model/hive_model/progress_model.dart';
import 'package:visual_novel_strider/utils/duration_parse.dart';

class PlayerController extends GetxController {
  final HiveRepository hiveRepository = Get.find();
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  StopWatchTimer get stopWatchTimer => _stopWatchTimer;

  ProgressModel? _nowPlaying;
  ProgressModel? get nowPlaying => _nowPlaying;

  final RxInt _stopList = 0.obs;
  RxInt get stopList => _stopList;

  // RxInt minutes = 0.obs, seconds = 0.obs;
  RxBool isPlaying = false.obs;

  void addPlayTime(String playtime, int id) {
    hiveRepository
        .result[hiveRepository.result.indexWhere((element) => element.id == id)]
        .playtime = playtime;
  }

  @override
  void onReady() {
    stopList.bindStream(_stopWatchTimer.rawTime);
    // minutes.bindStream(_stopWatchTimer.minuteTime);
    // seconds.bindStream(_stopWatchTimer.rawTime);
  }

  void starTimer(int index) {
    isPlaying.value = true;
    hiveRepository.result[index].isPlaying = true;
    hiveRepository.result[index].save();
    _nowPlaying = hiveRepository.result[index];
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);

    createMediaPlayerNotification();

    update();
  }

  void stopPlaying() async {
    await AwesomeNotifications().cancel(_nowPlaying!.id);
    isPlaying.value = false;

    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    List<int> newTime = DurationParsing.durationStringToInt(
        StopWatchTimer.getDisplayTime(_stopWatchTimer.rawTime.value,
            hours: true));

    String oldTime = _nowPlaying!.playtime;

    int oldHours = int.parse(oldTime.removeAllWhitespace.split("hours").first);
    int oldminutes = int.parse(
        oldTime.removeAllWhitespace.split("hours").last.split("minutes").first);

    var oy = Duration(hours: oldHours, minutes: oldminutes);
    var date = DateTime(2021)
        .add(oy)
        .add(Duration(hours: newTime[0], minutes: newTime[1]));

    String playtime =
        date.hour.toString() + " hours " + date.minute.toString() + " minutes";

    var lastPlayed = DateTime.now();

    _nowPlaying!.isPlaying = false;
    _nowPlaying!.playtime = playtime;
    nowPlaying!.lastPlayed = lastPlayed;
    _nowPlaying!.save();
    _nowPlaying = null;

    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);

    update();
  }

  void pauseTimer() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
  }

  void resumeTimer() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  void createMediaPlayerNotification() async {
    log("aw");
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: _nowPlaying!.id,
          channelKey: 'media_player',
          title: "tes",
          body: "test",
          summary: 'Now playing',
          notificationLayout: NotificationLayout.MediaPlayer,
          color: Colors.purple.shade700,
          autoCancel: false,
          showWhen: false),
    );
  }
}
