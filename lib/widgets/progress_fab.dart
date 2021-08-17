import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/hive_repository.dart';
import 'package:visual_novel_strider/model/chara_item.dart';
import 'package:visual_novel_strider/model/item.dart';

class ProgressFab extends StatelessWidget {
  ProgressFab({Key? key, required this.charaItem, required this.item})
      : super(key: key);

  final HiveRepository _hiveRepository = Get.find();
  final List<CharaItem> charaItem;
  final Item item;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return FloatingActionButton.extended(
      onPressed: () {
        log(charaItem[0].name!);
        log(charaItem[0].traits[2][0].toString());
        _hiveRepository.addItem(charaItem, item);
        Get.showSnackbar(GetBar(
          backgroundColor: _theme.primaryColor,
          icon: Icon(
            CupertinoIcons.check_mark_circled_solid,
            color: _theme.accentColor,
          ),
          duration: Duration(seconds: 2),
          title: item.title,
          message: "Added to your Inventory",
        ));
      },
      backgroundColor: _theme.primaryColor,
      foregroundColor: _theme.accentColor,
      label: Text("Add to progress"),
      icon: Icon(CupertinoIcons.add),
    );
  }
}
