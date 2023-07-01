// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/player_controller.dart';
import 'package:visual_novel_strider/model/hive_model/hive_model.dart';

import '../controller&repository/notification_controller.dart';

class CharacterCardBottomSheet extends StatelessWidget {
  CharacterCardBottomSheet({Key? key, required this.index, required this.item})
      : super(key: key);

  final NotificationController _notificationController = Get.find();

  final int index;

  final HiveVNModel item;

  final PlayerController _playerController = Get.find();

  @override
  Widget build(BuildContext context) {
    final TextEditingController _hoursController = TextEditingController();
    final TextEditingController _minutesController = TextEditingController();

    var _theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
            Get.bottomSheet(
                FractionallySizedBox(
                  widthFactor: 0.75,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        "How long do you play this route today?",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style:
                            TextStyle(color: _theme.accentColor, fontSize: 22),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            child: TextField(
                              controller: _hoursController,
                              keyboardType: TextInputType.number,
                              cursorColor: _theme.accentColor,
                              style: TextStyle(color: _theme.accentColor),
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(0),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: _theme.accentColor)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: _theme.accentColor)),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: _theme.accentColor))),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "hours",
                            style: TextStyle(
                                color: _theme.accentColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            width: 20,
                            child: TextField(
                              controller: _minutesController,
                              keyboardType: TextInputType.number,
                              cursorColor: _theme.accentColor,
                              style: TextStyle(color: _theme.accentColor),
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(0),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: _theme.accentColor)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: _theme.accentColor)),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: _theme.accentColor))),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "minutes",
                            style: TextStyle(
                                color: _theme.accentColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                if (_hoursController.text.isEmpty ||
                                    _minutesController.text.isEmpty) {
                                  Get.back();
                                  Get.snackbar("Failed",
                                      "Add progress failed because hours or minutes is empty",
                                      backgroundColor: Color(
                                          _notificationController.hiveRepository
                                              .result[index].hexColor),
                                      colorText: _theme.accentColor,
                                      snackPosition: SnackPosition.TOP,
                                      snackStyle: SnackStyle.FLOATING);
                                } else {
                                  Get.back();
                                  _notificationController.addPlayTime(
                                      _hoursController.text,
                                      _minutesController.text,
                                      index);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(
                                          color: _theme.accentColor)),
                                  elevation: 0,
                                  primary: Colors.transparent),
                              child: const Text("Add")),
                          ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide.none),
                                  elevation: 0,
                                  primary: Colors.transparent),
                              child: const Text("Cancel"))
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
                ),
                backgroundColor: Color(_notificationController
                    .hiveRepository.result[index].hexColor));
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 0, 0),
            child: Row(
              children: [
                Icon(
                  Icons.add_alarm_rounded,
                  color: _theme.accentColor,
                  size: 32,
                ),
                const SizedBox(
                  width: 32,
                ),
                Text(
                  "Add Progress",
                  style: TextStyle(
                      color: _theme.accentColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.back();
            _playerController.isPlaying.value
                ? Get.showSnackbar(GetBar(
                    backgroundColor: _theme.primaryColor,
                    icon: Icon(
                      CupertinoIcons.xmark_circle,
                      color: _theme.accentColor,
                    ),
                    duration: const Duration(seconds: 5),
                    title: "No, you can't!",
                    message:
                        "Unfortunately, you can't play two girl at the same time! :(",
                  ))
                : _playerController.starTimer(index);
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 0, 0),
            child: Row(
              children: [
                Icon(
                  Icons.play_arrow_rounded,
                  color: _theme.accentColor,
                  size: 32,
                ),
                const SizedBox(
                  width: 32,
                ),
                Text(
                  "Play",
                  style: TextStyle(
                      color: _theme.accentColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.back();
            _notificationController.deleteProgress(index, item.id);
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 0, 0),
            child: Row(
              children: [
                Icon(
                  Icons.delete,
                  color: _theme.accentColor,
                  size: 32,
                ),
                const SizedBox(
                  width: 32,
                ),
                Text(
                  "Delete",
                  style: TextStyle(
                      color: _theme.accentColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
