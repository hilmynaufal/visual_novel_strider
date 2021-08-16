// ignore_for_file: unused_import

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/model/chara_item.dart';
import 'package:visual_novel_strider/model/hive_model/hive_model.dart';
import 'package:visual_novel_strider/notification_controller.dart';
import 'package:visual_novel_strider/utils/duration_parse.dart';

class CharacterCard extends StatelessWidget {
  CharacterCard({Key? key, required this.index, required this.item})
      : super(key: key);

  int index;

  final NotificationController _notificationController = Get.find();

  final HiveVNModel item;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _hoursController = TextEditingController();
    final TextEditingController _minutesController = TextEditingController();

    final _theme = Theme.of(context);

    final List<Color> colors = [
      const Color(0xFFEAAEAE),
      const Color(0xFFB3BCEC),
      Color(0xFFE6A895),
      Colors.grey.shade400,
      Colors.orange.shade300,
      Colors.orange.shade400,
    ];
    return Column(
      children: [
        FractionallySizedBox(
            widthFactor: 0.95,
            child: ElevatedButton(
              onPressed: () {
                Get.bottomSheet(
                    Column(
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
                                      SizedBox(
                                        height: 32,
                                      ),
                                      Text(
                                        "How long do you play this route today?",
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: _theme.accentColor,
                                            fontSize: 22),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 20,
                                            child: TextField(
                                              controller: _hoursController,
                                              keyboardType:
                                                  TextInputType.number,
                                              cursorColor: _theme.accentColor,
                                              style: TextStyle(
                                                  color: _theme.accentColor),
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.all(0),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: _theme
                                                                  .accentColor)),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: _theme
                                                                  .accentColor)),
                                                  border: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: _theme
                                                              .accentColor))),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            "hours",
                                            style: TextStyle(
                                                color: _theme.accentColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                            width: 20,
                                            child: TextField(
                                              controller: _minutesController,
                                              keyboardType:
                                                  TextInputType.number,
                                              cursorColor: _theme.accentColor,
                                              style: TextStyle(
                                                  color: _theme.accentColor),
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.all(0),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: _theme
                                                                  .accentColor)),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: _theme
                                                                  .accentColor)),
                                                  border: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: _theme
                                                              .accentColor))),
                                            ),
                                          ),
                                          SizedBox(
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
                                      SizedBox(
                                        height: 32,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                if (_hoursController
                                                        .text.isNotEmpty ||
                                                    _minutesController
                                                        .text.isNotEmpty) {
                                                  Get.back();
                                                  _notificationController
                                                      .addPlayTime(
                                                          _hoursController.text,
                                                          _minutesController
                                                              .text,
                                                          index);
                                                } else {
                                                  Get.back();
                                                  Get.snackbar("Failed",
                                                      "Add progress failed because hours or minutes is empty",
                                                      backgroundColor:
                                                          colors[index],
                                                      colorText:
                                                          _theme.accentColor,
                                                      snackPosition:
                                                          SnackPosition.TOP,
                                                      snackStyle:
                                                          SnackStyle.FLOATING);
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  splashFactory:
                                                      NoSplash.splashFactory,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      side: BorderSide(
                                                          color: _theme
                                                              .accentColor)),
                                                  elevation: 0,
                                                  primary: Colors.transparent),
                                              child: Text("Add")),
                                          ElevatedButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  splashFactory:
                                                      NoSplash.splashFactory,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      side: BorderSide.none),
                                                  elevation: 0,
                                                  primary: Colors.transparent),
                                              child: Text("Cancel"))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 32,
                                      ),
                                    ],
                                  ),
                                ),
                                backgroundColor: colors[index]);
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(16, 8, 0, 0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_alarm_rounded,
                                  color: _theme.accentColor,
                                  size: 32,
                                ),
                                SizedBox(
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
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.fromLTRB(16, 8, 0, 0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.play_arrow_rounded,
                                  color: _theme.accentColor,
                                  size: 32,
                                ),
                                SizedBox(
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
                            _notificationController.deleteProgress(index);
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(16, 8, 0, 0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: _theme.accentColor,
                                  size: 32,
                                ),
                                SizedBox(
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
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                    backgroundColor: colors[index]);
              },
              style: ElevatedButton.styleFrom(
                  elevation: 4,
                  padding: EdgeInsets.all(16),
                  primary: colors[index],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            fit: BoxFit.none,
                            width: 60,
                            height: 100,
                            imageScale: 3,
                            alignment: Alignment.topCenter,
                            image: _notificationController.hiveRepository
                                .result[index].character!.image!),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _notificationController.hiveRepository
                                  .result[index].character!.name!,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _notificationController.hiveRepository
                                  .result[index].character!.original!,
                              style: TextStyle(
                                  fontSize: 8, fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.watch_later_outlined,
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  formatDate(
                                      _notificationController.hiveRepository
                                          .result[index].lastPlayed,
                                      [dd, ' ', M, ' ', yyyy]),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.gamepad_rounded,
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                GetBuilder<NotificationController>(
                                    builder: (_) {
                                  return Text(
                                    _.hiveRepository.result[index].playtime,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  );
                                }),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.track_changes_outlined,
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  durationToString(_notificationController
                                      .hiveRepository.result[index].endTime),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GetBuilder<NotificationController>(
                        builder: (_) => Column(children: [
                          FlutterSwitch(
                            toggleColor: colors[index],
                            activeColor: Colors.white.withOpacity(0.5),
                            height: 30,
                            width: 50,
                            toggleSize: 20,
                            showOnOff: true,
                            valueFontSize: 11,
                            activeIcon: Icon(
                              Icons.remove_circle,
                              size: 11,
                            ),
                            inactiveIcon: Icon(
                              Icons.time_to_leave,
                              size: 11,
                            ),
                            value: _.hiveRepository.result[index].hasReminder,
                            onToggle: (value) async {
                              _.setReminderFromButton(
                                  value, index, item.title!);
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Icon(
                            Icons.alarm,
                            size: 16,
                          ),
                          Text(
                            _.hiveRepository.result[index].reminder,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    _notificationController
                            .hiveRepository.result[index].note.isEmpty
                        ? _notificationController.hiveRepository.result[index]
                                .character!.description ??
                            "No description"
                        : _notificationController
                            .hiveRepository.result[index].note,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  String durationToString(String duration) {
    List<int> time = DurationParsing.durationStringToInt(duration);
    String temp =
        time[0].toString() + ' hour ' + time[1].toString() + ' minute';
    return temp;
  }
}
