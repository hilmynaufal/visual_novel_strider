// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/player_controller.dart';

import '../controller&repository/notification_controller.dart';
import '../model/hive_model/progress_model.dart';

class CharacterCardBottomSheet extends StatelessWidget {
  CharacterCardBottomSheet({Key? key, required this.progressModel})
      : super(key: key);

  final NotificationController _notificationController = Get.find();

  // final int index;

  // final DetailResult item;
  final ProgressModel progressModel;

  final PlayerController _playerController = Get.find();

  @override
  Widget build(BuildContext context) {
    final TextEditingController hoursController = TextEditingController();
    final TextEditingController minutesController = TextEditingController();

    var theme = Theme.of(context);

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
                        style: TextStyle(
                            color: theme.primaryColorLight, fontSize: 22),
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
                              controller: hoursController,
                              keyboardType: TextInputType.number,
                              cursorColor: theme.primaryColorLight,
                              style: TextStyle(color: theme.primaryColorLight),
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(0),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: theme.primaryColorLight)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: theme.primaryColorLight)),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: theme.primaryColorLight))),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "hours",
                            style: TextStyle(
                                color: theme.primaryColorLight,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            width: 20,
                            child: TextField(
                              controller: minutesController,
                              keyboardType: TextInputType.number,
                              cursorColor: theme.primaryColorLight,
                              style: TextStyle(color: theme.primaryColorLight),
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(0),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: theme.primaryColorLight)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: theme.primaryColorLight)),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: theme.primaryColorLight))),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "minutes",
                            style: TextStyle(
                                color: theme.primaryColorLight,
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
                                if (hoursController.text.isEmpty ||
                                    minutesController.text.isEmpty) {
                                  Get.back();
                                  Get.snackbar("Failed",
                                      "Add progress failed because hours or minutes is empty",
                                      backgroundColor:
                                          Color(progressModel.hexColor),
                                      colorText: theme.primaryColorLight,
                                      snackPosition: SnackPosition.TOP,
                                      snackStyle: SnackStyle.FLOATING);
                                } else {
                                  Get.back();
                                  _notificationController.addPlayTime(
                                      hoursController.text,
                                      minutesController.text,
                                      progressModel);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(
                                          color: theme.primaryColorLight)),
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
                backgroundColor: Color(progressModel.hexColor));
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 0, 0),
            child: Row(
              children: [
                Icon(
                  Icons.add_alarm_rounded,
                  color: theme.primaryColorLight,
                  size: 32,
                ),
                const SizedBox(
                  width: 32,
                ),
                Text(
                  "Add Progress",
                  style: TextStyle(
                      color: theme.primaryColorLight,
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
                    backgroundColor: theme.primaryColor,
                    icon: Icon(
                      CupertinoIcons.xmark_circle,
                      color: theme.primaryColorLight,
                    ),
                    duration: const Duration(seconds: 5),
                    title: "No, you can't!",
                    message:
                        "Unfortunately, you can't play two girl at the same time! :(",
                  ))
                : _playerController.starTimer(progressModel);
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 0, 0),
            child: Row(
              children: [
                Icon(
                  Icons.play_arrow_rounded,
                  color: theme.primaryColorLight,
                  size: 32,
                ),
                const SizedBox(
                  width: 32,
                ),
                Text(
                  "Play",
                  style: TextStyle(
                      color: theme.primaryColorLight,
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
            _notificationController.deleteProgress(progressModel);
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 0, 0),
            child: Row(
              children: [
                Icon(
                  Icons.delete,
                  color: theme.primaryColorLight,
                  size: 32,
                ),
                const SizedBox(
                  width: 32,
                ),
                Text(
                  "Delete",
                  style: TextStyle(
                      color: theme.primaryColorLight,
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
