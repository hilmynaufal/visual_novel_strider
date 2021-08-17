// ignore_for_file: unused_import

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/controller&repository/player_controller.dart';

import 'package:visual_novel_strider/model/chara_item.dart';
import 'package:visual_novel_strider/model/hive_model/hive_model.dart';
import 'package:visual_novel_strider/controller&repository/notification_controller.dart';
import 'package:visual_novel_strider/utils/duration_parse.dart';
import 'package:visual_novel_strider/widgets/character_card_bottom_sheets.dart';
import 'package:visual_novel_strider/widgets/player.dart';

class CharacterCard extends StatelessWidget {
  CharacterCard({Key? key, required this.index, required this.item})
      : super(key: key);

  int index;

  final NotificationController _notificationController = Get.find();

  final HiveVNModel item;

  final PlayerController _playerController = Get.find();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Column(
      children: [
        FractionallySizedBox(
            widthFactor: 0.95,
            child: ElevatedButton(
              onPressed: () {
                Get.bottomSheet(
                    CharacterCardBottomSheet(index: index, item: item),
                    backgroundColor: Color(_notificationController
                        .hiveRepository.result[index].hexColor));
              },
              style: ElevatedButton.styleFrom(
                  elevation: 4,
                  padding: EdgeInsets.all(16),
                  primary: Color(_notificationController
                      .hiveRepository.result[index].hexColor),
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
                            toggleColor: Color(_notificationController
                                .hiveRepository.result[index].hexColor),
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
                  GetBuilder<PlayerController>(
                      builder: (_) => _.hiveRepository.result[index].isPlaying
                          ? Player(
                              index: index,
                            )
                          : Text("l"))
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
