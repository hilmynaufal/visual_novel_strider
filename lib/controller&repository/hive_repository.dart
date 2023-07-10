import 'dart:async';
import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';
import 'package:visual_novel_strider/model/kana_model/individual_result.dart';
import 'package:visual_novel_strider/model/hive_model/progress_model.dart';

class HiveRepository extends GetxController {
  Box<DetailResult>? box;
  Box<ProgressModel>? progressBox;
  var isReady = false.obs;
  RxBool isLatestScheduleReady = false.obs;

  List<DetailResult>? data = [];
  List<ProgressModel>? progressData = [];

  //initial
  RxList<ProgressModel> result = [
    ProgressModel(
        id: '0',
        character: null,
        reminder: "",
        playtime: "",
        lastPlayed: DateTime.now(),
        hexColor: 0xFF,
        isCompleted: false,
        endTime: "",
        hasReminder: false,
        isPlaying: false,
        vnId: '',
        note: "")
  ].obs;

  Map<int, int> hairColor = {
    8: 0xFFEAAEAE,
    7: 0xFFB3BCEC,
    956: Colors.grey.shade400.value,
    6: 0xFF8D5F51,
    1305: Colors.orange.shade300.value,
    10: 0xffB94E5C,
    9: 0xFFBF6BA6,
    4: 0xFF393B52,
    50: 0xFFB1BA92,
    919: Colors.cyan.shade400.value,
    926: Colors.teal.shade300.value,
    5: 0xFFFBDEB7
  };

  Map<int, int> eyeColor = {
    110: 0xFFB3BCEC,
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
    111: Colors.grey.shade400.value
  };

  StreamController<List<ProgressModel>> progressStreamController =
      StreamController<List<ProgressModel>>();

  @override
  void onInit() async {
    super.onInit();
    box = await Hive.openBox<DetailResult>('inventory');
    progressBox = await Hive.openBox<ProgressModel>('progress');
    getItem();
    result.bindStream(progressStreamController.stream);
  }

  Future<void> getItem() async {
    isReady.value = false;
    data = box!.values.toList();
    progressData = progressBox!.values.toList();
    isReady.value = true;
    log("item get");
    update();
  }

  void getLatestSchedule() async {
    isLatestScheduleReady.value = false;
    List<ProgressModel> _temp = progressBox!.values
        .where((element) => element.hasReminder == true)
        .toList();

    _temp.sort((x, y) => x.reminder.compareTo(y.reminder));

    log("schedule length = " + _temp.length.toString());

    if (_temp.isNotEmpty) {
      progressStreamController.add(_temp);
    } else {
      progressStreamController.add([
        ProgressModel(
            id: '0',
            character: null,
            reminder: "",
            playtime: "",
            lastPlayed: DateTime.now(),
            hexColor: 0xFF,
            isCompleted: false,
            endTime: "",
            hasReminder: false,
            isPlaying: false,
            vnId: '',
            note: "")
      ]);
    }
    isLatestScheduleReady.value = true;
  }

  void getCharactersRoute(String vnId) {
    List<ProgressModel> _temp =
        progressBox!.values.where((element) => element.vnId == vnId).toList();
    if (_temp.isNotEmpty) {
      progressStreamController.add(_temp);
    } else {
      progressStreamController.add([
        ProgressModel(
            id: '0',
            character: null,
            reminder: "",
            playtime: "",
            lastPlayed: DateTime.now(),
            hexColor: 0xFF,
            isCompleted: false,
            endTime: "",
            hasReminder: false,
            isPlaying: false,
            vnId: '',
            note: "")
      ]);
    }
  }

  void addItem(
      List<IndividualResult> individualResult, DetailResult detailResult) {
    detailResult.characters = individualResult;
    detailResult.isComplete = false;

    log("chara = " + individualResult.length.toString());

    if (checkIfAdded(detailResult)) {
      log('added');
      box!.add(detailResult);
    }
  }

  void addToProgress(
      IndividualResult hiveCHaractersModel,
      String reminder,
      int hexColor,
      bool hasReminder,
      String vnID,
      Duration endTime,
      String note) {
    var _value = ProgressModel(
        id: hiveCHaractersModel.id,
        character: hiveCHaractersModel,
        reminder: reminder,
        playtime: "0 hours 0 minutes",
        lastPlayed: DateTime.now(),
        hexColor: hexColor,
        isCompleted: false,
        endTime: endTime.toString(),
        hasReminder: hasReminder,
        isPlaying: false,
        vnId: vnID,
        note: note);
    progressBox!.put(hiveCHaractersModel.id, _value);
  }

  Future<void> deleteProgressFromBox(int index, String vnId) async {
    await result[index].delete();

    getCharactersRoute(vnId);

    update();
  }

  //TODO: Fix if added
  bool checkIfAdded(DetailResult item) {
    if (data!.firstWhereOrNull((element) => element.id == item.id) == null) {
      return true;
    }
    return false;
    // for (int i = 0; i < data!.length; i++) {
    //   if (data![i].id == item.id) {
    //     return true;
    //   }
    // }
    // return false;
  }
}
