import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/playground_controller.dart';
import 'package:visual_novel_strider/utils/datetime_parse.dart';
import 'package:visual_novel_strider/widgets/playground/playground_header.dart';
import 'package:visual_novel_strider/widgets/playground/playground_node_indicator.dart';

class RoutePlaygroundPage extends StatelessWidget {
  const RoutePlaygroundPage({Key? key}) : super(key: key);
  // final DetailResult item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final PlaygroundController playgroundController = Get.find();
    // final NotificationController _notificationController = Get.find();
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) =>
              [PlaygroundHeader()],
          body: Container(
            decoration: BoxDecoration(
                color: theme.primaryColorLight,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: theme.primaryColor,
                                  padding: const EdgeInsets.all(20),
                                  backgroundColor: theme.primaryColorLight,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              child: const Icon(
                                CupertinoIcons.pause_fill,
                                size: 40,
                                color: Colors.black,
                              )),
                          const SizedBox(
                            width: 16,
                          ),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: theme.primaryColor,
                                  padding: const EdgeInsets.all(20),
                                  backgroundColor: theme.primaryColorLight,
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
                                    playgroundController
                                        .curentPlaythrough
                                        .value!
                                        .eventNodes[0]
                                        .character!
                                        .image!
                                        .url,
                                    alignment: Alignment.topCenter,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              )),
                          const SizedBox(
                            width: 16,
                          ),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: theme.primaryColor,
                                  padding: const EdgeInsets.all(20),
                                  backgroundColor: theme.primaryColorLight,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              child: const Icon(
                                CupertinoIcons.stop_fill,
                                size: 40,
                                color: Colors.black,
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Last Played ${DateTimeParse.parseDateTime(playgroundController.currentNode.value!.lastPlayed.toString())}    Created ${DateTimeParse.parseDateTime(playgroundController.currentNode.value!.createdAt.toString())}",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontWeight: FontWeight.w200, fontSize: 12),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Previous Node: Common Route",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                              const SizedBox(
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
                                alignment: Alignment.topCenter,
                                child: ClipOval(
                                  child: Image.network(playgroundController
                                      .curentPlaythrough
                                      .value!
                                      .eventNodes[0]
                                      .character!
                                      .image!
                                      .url),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Next Node: ${playgroundController.currentNode.value!.nodeType}",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                              const SizedBox(
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
                                alignment: Alignment.topCenter,
                                child: ClipOval(
                                  child: Image.network(playgroundController
                                      .curentPlaythrough
                                      .value!
                                      .eventNodes[0]
                                      .character!
                                      .image!
                                      .url),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Row(
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
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            padding: const EdgeInsets.all(8),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Column(
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
                                ],
                              ),
                            ),
                          ),
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
