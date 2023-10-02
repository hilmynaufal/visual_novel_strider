// ignore_for_file: unused_import

import 'dart:developer';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/controller&repository/detail_repository.dart';
import 'package:visual_novel_strider/controller&repository/player_controller.dart';

import 'package:visual_novel_strider/model/hive_model/hive_model.dart';
import 'package:visual_novel_strider/controller&repository/notification_controller.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';
import 'package:visual_novel_strider/model/kana_model/node_model.dart';
import 'package:visual_novel_strider/utils/duration_parse.dart';
import 'package:visual_novel_strider/widgets/character_card_bottom_sheets.dart';
import 'package:visual_novel_strider/widgets/player.dart';

import '../model/hive_model/progress_model.dart';

// ignore: must_be_immutable
class CharacterCard extends StatelessWidget {
  const CharacterCard(
      {Key? key, required this.nodeModel, required this.onCardPressed})
      : super(key: key);

  // final NotificationController _notificationController = Get.find();

  // final DetailResult item;
  final dynamic nodeModel;
  final void Function() onCardPressed;

  @override
  Widget build(BuildContext context) {
    log((nodeModel is ProgressModel).toString());
    return FractionallySizedBox(
        heightFactor: 0.95,
        widthFactor: 0.95,
        child: ElevatedButton(
          onPressed: () {
            // Get.bottomSheet(CharacterCardBottomSheet(progressModel: nodeModel),
            //     backgroundColor: Color(nodeModel.hexColor));
            onCardPressed();
          },
          style: ElevatedButton.styleFrom(
              elevation: 4,
              backgroundColor: Color(nodeModel.hexColor),
              shadowColor: Color(nodeModel.hexColor),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
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
                        image: nodeModel.character!.image!.url),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nodeModel.character!.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          nodeModel.character!.original!,
                          style: const TextStyle(
                              fontSize: 8, fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.watch_later_outlined,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              formatDate(nodeModel.lastPlayed,
                                  [dd, ' ', M, ' ', yyyy]),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.gamepad_rounded,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            GetBuilder<NotificationController>(builder: (_) {
                              return Text(
                                nodeModel.playtime,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w300),
                              );
                            }),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.track_changes_outlined,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              durationToString(nodeModel.endTime),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Column(children: [
                    // FlutterSwitch(
                    //   toggleColor: Color(nodeModel.hexColor),
                    //   activeColor: Colors.white.withOpacity(0.5),
                    //   height: 30,
                    //   width: 50,
                    //   toggleSize: 20,
                    //   showOnOff: true,
                    //   valueFontSize: 11,
                    //   activeIcon: const Icon(
                    //     Icons.remove_circle,
                    //     size: 11,
                    //   ),
                    //   inactiveIcon: const Icon(
                    //     Icons.time_to_leave,
                    //     size: 11,
                    //   ),
                    //   value: nodeModel.ha,
                    //   onToggle: (value) async {
                    //     _.setReminderFromButton(value, index, item.title);
                    //   },
                    // ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    // const Icon(
                    //   Icons.alarm,
                    //   size: 16,
                    // ),
                    // Text(
                    //   _.hiveRepository.result[index].reminder,
                    //   style: const TextStyle(
                    //       fontSize: 16, fontWeight: FontWeight.bold),
                    // ),
                  ]),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                nodeModel.note.isNotEmpty
                    ? nodeModel.note
                    : nodeModel.character!.description ?? "No description",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ));
  }

  String durationToString(String duration) {
    List<int> time = DurationParsing.durationStringToInt(duration);
    String temp = '${time[0]} hours ${time[1]} minutes';
    return temp;
  }
}
