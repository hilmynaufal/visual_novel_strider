import 'dart:core';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';
import 'package:visual_novel_strider/model/kana_model/individual_result.dart';
import 'package:visual_novel_strider/model/hive_model/progress_model.dart';

class HiveRepository extends GetxController {
  late Box<DetailResult> box;
  Box<ProgressModel>? progressBox;
  var isReady = false.obs;
  RxBool isLatestScheduleReady = false.obs;

  List<DetailResult>? data = [];
  List<ProgressModel> progressData = [];
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
    await getItem();
    // result.bindStream(progressStreamController.stream);
  }

  Future<void> getItem() async {
    isReady.value = false;
    data = box.values.toList();
    // progressData = progressBox!.values.toList();
    isReady.value = true;
    log("item get");
    update();
  }

  Future<void> getProgressDataWithVNId(String vnId) async {
    isReady.value = false;
    // data = box.values.toList();
    progressData =
        progressBox!.values.where((element) => element.vnId == vnId).toList();
    isReady.value = true;
    log("progress get");
    update();
  }

  void getLatestSchedule() async {
    isLatestScheduleReady.value = false;
    List<ProgressModel> temp = progressBox!.values
        .where((element) => element.hasReminder == true)
        .toList();

    temp.sort((x, y) => x.reminder.compareTo(y.reminder));

    log("schedule length = ${temp.length}");

    scheduleData.value = temp;

    isLatestScheduleReady.value = true;
  }

  void getCharactersRoute(String vnId) {
    isReady.value = false;
    List<ProgressModel> temp =
        progressBox!.values.where((element) => element.vnId == vnId).toList();
    if (temp.isNotEmpty) {
      result.value = temp;
    }
    isReady.value = true;
    // update();
  }

  void addItem(
      List<IndividualResult> individualResult, DetailResult detailResult) {
    detailResult.characters = individualResult;
    detailResult.isComplete = false;

    log("chara = ${individualResult.length}");

    if (checkIfAdded(detailResult)) {
      log('added');
      box.add(detailResult);
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
    final now = DateTime.now();
    var value = ProgressModel(
        id: hiveCHaractersModel.id,
        character: hiveCHaractersModel,
        reminder: reminder,
        playtime: "0 hours 0 minutes",
        lastPlayed: now,
        hexColor: hexColor,
        isCompleted: false,
        endTime: endTime.toString(),
        hasReminder: hasReminder,
        isPlaying: false,
        vnId: vnID,
        note: note,
        createdAt: now);
    progressBox!.put(hiveCHaractersModel.id, value);
    update();
  }

  Future<void> deleteProgressFromBox(
      ProgressModel progressModel, String vnid) async {
    await progressModel.delete();
    String id = progressModel.vnId;
    getCharactersRoute(id);

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
