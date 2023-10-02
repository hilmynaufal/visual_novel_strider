// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/hive_repository.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';
import 'package:visual_novel_strider/model/kana_model/individual_result.dart';

class ProgressFab extends StatelessWidget {
  ProgressFab({Key? key, required this.charaItem, required this.item})
      : super(key: key);

  final HiveRepository _hiveRepository = Get.find();
  final List<IndividualResult> charaItem;
  final DetailResult item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FloatingActionButton.extended(
      onPressed: () {
        _hiveRepository.addItem(charaItem, item);
        Get.showSnackbar(GetBar(
          backgroundColor: theme.primaryColor,
          icon: Icon(
            CupertinoIcons.check_mark_circled_solid,
            color: theme.primaryColorLight,
          ),
          duration: const Duration(seconds: 2),
          title: item.title,
          message: "Added to your Inventory",
        ));
      },
      backgroundColor: theme.primaryColor,
      foregroundColor: theme.primaryColorLight,
      label: Text("Add to progress"),
      icon: Icon(CupertinoIcons.add),
    );
  }
}
