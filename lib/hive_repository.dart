import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:visual_novel_strider/model/chara_item.dart';
import 'package:visual_novel_strider/model/hive_model/hive_characters_model.dart';
import 'package:visual_novel_strider/model/hive_model/hive_model.dart';
import 'package:visual_novel_strider/model/item.dart';

class HiveRepository extends GetxController {
  Box<HiveVNModel>? box;
  bool isReady = false;
  List<HiveVNModel>? data = [];

  @override
  void onInit() async {
    box = await Hive.openBox<HiveVNModel>('inventory');
    await getItem();
  }

  Future<void> getItem() async {
    isReady = false;
    data = box!.values.toList();
    isReady = true;
    log(data!.length.toString());
    update();
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
          age: _charaItem[i].age);
      _charactersList.add(characters);
    }

    temp.characters = _charactersList;

    if (!checkIfAdded(_item)) {
      log('added');
      box!.add(temp);
    }
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
