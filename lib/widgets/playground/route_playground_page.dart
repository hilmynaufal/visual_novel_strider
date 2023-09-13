import 'dart:developer';

import 'package:backdrop/backdrop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/notification_controller.dart';
import 'package:visual_novel_strider/controller&repository/playground_controller.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';
import 'package:visual_novel_strider/model/old_socket_model/media.dart';
import 'package:visual_novel_strider/widgets/character_card.dart';
import 'package:visual_novel_strider/widgets/empty_widget.dart';
import 'package:visual_novel_strider/widgets/playground/playground_header.dart';
import 'package:visual_novel_strider/widgets/playground/playground_node_indicator.dart';

class RoutePlaygroundPage extends StatelessWidget {
  const RoutePlaygroundPage({Key? key}) : super(key: key);
  // final DetailResult item;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    final PlaygroundController playgroundController = Get.find();
    // final NotificationController _notificationController = Get.find();

    // log(_notificationController.hiveRepository.result[0].hexColor.toString());
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) =>
              [PlaygroundHeader()],
          body: Container(
            decoration: BoxDecoration(
                color: _theme.accentColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(20),
                                  primary: _theme.accentColor,
                                  onPrimary: _theme.primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              child: Icon(
                                CupertinoIcons.pause_fill,
                                size: 40,
                                color: Colors.black,
                              )),
                          SizedBox(
                            width: 16,
                          ),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(20),
                                  primary: _theme.accentColor,
                                  onPrimary: _theme.primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              child: Container(
                                height: 40,
                                clipBehavior: Clip.antiAlias,
                                width: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 1)),
                                child: ClipOval(
                                  child: Image.network(
                                    playgroundController.playthroughModel.value!
                                        .nodes[0].character!.image!.url,
                                    alignment: Alignment.topCenter,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              )),
                          SizedBox(
                            width: 16,
                          ),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(20),
                                  primary: _theme.accentColor,
                                  onPrimary: _theme.primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              child: Icon(
                                CupertinoIcons.stop_fill,
                                size: 40,
                                color: Colors.black,
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            padding: EdgeInsets.all(8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  PlaygroundNodeIndicator(
                                    isNextNode: false,
                                  ),
                                  PlaygroundNodeIndicator(
                                    isNextNode: false,
                                  ),
                                  PlaygroundNodeIndicator(
                                    isNextNode: true,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Text(
                            "Last Played: 2 Aug 2022    Created 1 Aug 2022",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.w200, fontSize: 12),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Text(
                                "Previous Node: Common Route",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                height: 20,
                                width: 20,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.black),
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: Image.network(playgroundController
                                      .playthroughModel
                                      .value!
                                      .nodes[0]
                                      .character!
                                      .image!
                                      .url),
                                ),
                                alignment: Alignment.topCenter,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Next Node: Route Branch",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                height: 20,
                                width: 20,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.black),
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: Image.network(playgroundController
                                      .playthroughModel
                                      .value!
                                      .nodes[0]
                                      .character!
                                      .image!
                                      .url),
                                ),
                                alignment: Alignment.topCenter,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text("2h 4m",
                                      style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w600)),
                                  Text("PLAYTIME",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w200))
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Text("3h 4m",
                                      style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w600)),
                                  Text("TARGET",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w200))
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
      extendBody: true,
      // headerHeight: _headerHeight,
    );
  }
}
