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
  var scheduleData = [].obs;

  //initial
  //TODO: #1 bug fix
  var result = [].obs;

  // StreamController<List<ProgressModel>> progressStreamController =
  //     StreamController<List<ProgressModel>>();

  @override
  void onInit() async {
    super.onInit();
    box = await Hive.openBox<DetailResult>('inventory');
    progressBox = await Hive.openBox<ProgressModel>('progress');
    getItem();
    // result.bindStream(progressStreamController.stream);
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

    scheduleData.value = _temp;

    isLatestScheduleReady.value = true;
  }

  void getCharactersRoute(String vnId) {
    List<ProgressModel> _temp =
        progressBox!.values.where((element) => element.vnId == vnId).toList();
    if (_temp.isNotEmpty) {
      result.value = _temp;
    } else {
      result.value = [
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
      ];
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
