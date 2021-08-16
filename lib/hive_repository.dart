import 'dart:async';
import 'dart:core';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:visual_novel_strider/model/chara_item.dart';
import 'package:visual_novel_strider/model/hive_model/hive_characters_model.dart';
import 'package:visual_novel_strider/model/hive_model/hive_model.dart';
import 'package:visual_novel_strider/model/hive_model/progress_model.dart';
import 'package:visual_novel_strider/model/item.dart';

class HiveRepository extends GetxController {
  Box<HiveVNModel>? box;
  Box<ProgressModel>? progressBox;
  bool isReady = false;

  List<HiveVNModel>? data = [];
  List<ProgressModel>? progressData = [];

  //initial
  RxList<ProgressModel> result = [
    ProgressModel(
        id: 0,
        character: null,
        reminder: "",
        playtime: "",
        lastPlayed: DateTime.now(),
        hexColor: 0xFF,
        isCompleted: false,
        endTime: "",
        hasReminder: false,
        isPlaying: false,
        vnId: 0,
        note: "")
  ].obs;

  StreamController<List<ProgressModel>> progressStreamController =
      StreamController<List<ProgressModel>>();

  @override
  void onInit() async {
    box = await Hive.openBox<HiveVNModel>('inventory');
    progressBox = await Hive.openBox<ProgressModel>('progress');
    getItem();
    result.bindStream(progressStreamController.stream);
  }

  Future<void> getItem() async {
    isReady = false;
    data = box!.values.toList();
    progressData = progressBox!.values.toList();
    isReady = true;
    log("item get");
    update();
  }

  void getCharactersRoute(int vnId) {
    List<ProgressModel> _temp =
        progressBox!.values.where((element) => element.vnId == vnId).toList();
    if (_temp.isNotEmpty) {
      progressStreamController.add(_temp);
    } else {
      progressStreamController.add([
        ProgressModel(
            id: 0,
            character: null,
            reminder: "",
            playtime: "",
            lastPlayed: DateTime.now(),
            hexColor: 0xFF,
            isCompleted: false,
            endTime: "",
            hasReminder: false,
            isPlaying: false,
            vnId: 0,
            note: "")
      ]);
    }
  }

  void addItem(List<CharaItem> _charaItem, Item _item) {
    HiveVNModel temp = HiveVNModel(
        id: _item.id,
        aliases: _item.aliases,
        popularity: _item.popularity,
        imageNsfw: _item.imageNsfw,
        links: _item.links,
        rating: _item.rating,
        platforms: _item.platforms,
        original: _item.original,
        tags: _item.tags,
        description: _item.description,
        votecount: _item.votecount,
        title: _item.title,
        origLang: _item.origLang,
        released: _item.released,
        languages: _item.languages,
        imageFlagging: _item.imageFlagging,
        image: _item.image,
        length: _item.length,
        screens: _item.screens);

    List<HiveCHaractersModel>? _charactersList = [];

    for (int i = 0; i < _charaItem.length; i++) {
      var characters = HiveCHaractersModel(
          id: _charaItem[i].id!,
          spoilGender: _charaItem[i].spoilGender,
          gender: _charaItem[i].gender.toString(),
          original: _charaItem[i].original,
          name: _charaItem[i].name,
          bloodt: _charaItem[i].bloodt,
          birthday: _charaItem[i].birthday,
          imageFlagging: _charaItem[i].imageFlagging,
          image: _charaItem[i].image,
          aliases: _charaItem[i].aliases,
          description: _charaItem[i].description,
          age: _charaItem[i].age,
          vns: _charaItem[i].vns);
      _charactersList.add(characters);
    }

    temp.characters = _charactersList;

    if (!checkIfAdded(_item)) {
      log('added');
      box!.add(temp);
    }
  }

  void addToProgress(HiveCHaractersModel hiveCHaractersModel, String reminder,
      int hexColor, bool hasReminder, int vnID, Duration endTime, String note) {
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
        isPlaying: true,
        vnId: vnID,
        note: note);
    progressBox!.put(hiveCHaractersModel.id, _value);
  }

  Future<void> deleteProgressFromBox(int index) async {
    await result[index].delete();

    update();
  }

  bool checkIfAdded(Item item) {
    for (int i = 0; i < data!.length; i++) {
      if (data![i].id == item.id) {
        return true;
      }
    }
    return false;
  }
}
