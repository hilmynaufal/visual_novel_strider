import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/controller&repository/notification_controller.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';

import '../create_bottom_sheets.dart';

class CharactersDrawer extends StatelessWidget {
  CharactersDrawer({Key? key, required this.item}) : super(key: key);

  final DetailResult item;

  final NotificationController _notificationController = Get.find();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            decoration: BoxDecoration(
                color: _theme.primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 127, 198, 255),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(children: [
                  Icon(
                    Icons.menu,
                    color: _theme.accentColor,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Characters Drawer",
                    style: TextStyle(
                        color: _theme.accentColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ]),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 16,
          color: Colors.yellow.shade500,
          child: Center(
            child: Text(
              "Some spoiler may be not filtered!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.yellow.shade900,
                  fontSize: 11,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              color: _theme.accentColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  children: item.characters!
                      .asMap()
                      .entries
                      .map((e) {
                        return ElevatedButton(
                          onPressed: () {
                            Get.bottomSheet(
                              CreateBottomSheet(
                                e: e.value,
                                vnID: item.id!,
                                title: item.title,
                              ),
                              enableDrag: true,
                              isScrollControlled: true,
                            ).whenComplete(() {
                              _notificationController.hiveRepository
                                  .getCharactersRoute(item.id!);
                              _notificationController.clearData();
                            });
                          },
                          clipBehavior: Clip.antiAlias,
                          style: ElevatedButton.styleFrom(
                              elevation: 4,
                              side: BorderSide(
                                  width: 0, color: _theme.accentColor),
                              padding: const EdgeInsets.all(0),
                              primary: _theme.accentColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14))),
                          child: e.value.image != null
                              ? SizedBox(
                                  height: 100,
                                  width: 70,
                                  child: ClipRRect(
                                      child: FadeInImage.memoryNetwork(
                                          fit: BoxFit.cover,
                                          imageScale: 3,
                                          alignment: Alignment.topCenter,
                                          placeholder: kTransparentImage,
                                          image: e.value.image!.url)))
                              : Container(
                                  height: 100,
                                  width: 70,
                                  child: Text("No Image"),
                                ),
                        );
                      })
                      .toList()
                      .cast<Widget>()),
            ),
          ),
        ),
      ],
    );
  }
}
