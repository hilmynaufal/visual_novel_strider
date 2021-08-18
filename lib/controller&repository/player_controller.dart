import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:visual_novel_strider/controller&repository/hive_repository.dart';
import 'package:visual_novel_strider/model/hive_model/progress_model.dart';

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
    _nowPlaying!.isPlaying = false;
    _nowPlaying!.save();
    _nowPlaying = null;
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
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
            title: _nowPlaying!.character!.name,
            body: _nowPlaying!.character!.name,
            summary: 'Now playing',
            notificationLayout: NotificationLayout.MediaPlayer,
            color: Colors.purple.shade700,
            autoCancel: false,
            showWhen: false),
        actionButtons: [
          // NotificationActionButton(
          //     key: 'MEDIA_PREV',
          //     icon: 'resource://drawable/res_ic_prev' +
          //         (MediaPlayerCentral.hasPreviousMedia ? '' : '_disabled'),
          //     label: 'Previous',
          //     autoCancel: false,
          //     enabled: MediaPlayerCentral.hasPreviousMedia,
          //     buttonType: ActionButtonType.KeepOnTop),
          // MediaPlayerCentral.isPlaying
          //     ? NotificationActionButton(
          //         key: 'MEDIA_PAUSE',
          //         icon: 'resource://drawable/res_ic_pause',
          //         label: 'Pause',
          //         autoCancel: false,
          //         buttonType: ActionButtonType.KeepOnTop)
          //     : NotificationActionButton(
          //         key: 'MEDIA_PLAY',
          //         icon: 'resource://drawable/res_ic_play' +
          //             (MediaPlayerCentral.hasAnyMedia ? '' : '_disabled'),
          //         label: 'Play',
          //         autoCancel: false,
          //         enabled: MediaPlayerCentral.hasAnyMedia,
          //         buttonType: ActionButtonType.KeepOnTop),
          // NotificationActionButton(
          //     key: 'MEDIA_NEXT',
          //     icon: 'resource://drawable/res_ic_next' +
          //         (MediaPlayerCentral.hasNextMedia ? '' : '_disabled'),
          //     label: 'Previous',
          //     enabled: MediaPlayerCentral.hasNextMedia,
          //     buttonType: ActionButtonType.KeepOnTop),
          // NotificationActionButton(
          //     key: 'MEDIA_CLOSE',
          //     icon: 'resource://drawable/res_ic_close',
          //     label: 'Close',
          //     autoCancel: true,
          //     buttonType: ActionButtonType.KeepOnTop)
        ]);
  }
}
