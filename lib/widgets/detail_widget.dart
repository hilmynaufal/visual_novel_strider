// ignore_for_file: deprecated_member_use

import 'package:backdrop/backdrop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/model/hive_model/hive_model.dart';
import 'package:visual_novel_strider/controller&repository/notification_controller.dart';
import 'package:visual_novel_strider/utils/duration_parse.dart';
import 'package:visual_novel_strider/widgets/character_card.dart';
import 'package:visual_novel_strider/widgets/create_bottom_sheets.dart';

class DetailWidget extends StatefulWidget {
  DetailWidget({Key? key, required this.item}) : super(key: key);

  final HiveVNModel item;

  final NotificationController _notificationController = Get.find();

  @override
  State<DetailWidget> createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  // final List<Color> _colors = [];

  // void updatePallete() async {
  //   for (int i = 0; i < widget.item.characters!.length; i++) {
  //     if (widget.item.characters![i].image != null) {
  //       final PaletteGenerator generator =
  //           await PaletteGenerator.fromImageProvider(
  //               NetworkImage(widget.item.characters![i].image!),
  //               size: const Size(200, 100));

  //       _colors.add(generator.vibrantColor!.color);
  //     } else {
  //       _colors.add(Colors.black);
  //     }
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    widget._notificationController.hiveRepository
        .getCharactersRoute(widget.item.id);

    return BackdropScaffold(
        appBar: BackdropAppBar(
          title: Text(
            "Detail",
            style: TextStyle(color: _theme.textSelectionTheme.selectionColor),
          ),
          elevation: 4,
          backgroundColor: _theme.primaryColor,
        ),
        backLayer: Container(
          margin: const EdgeInsets.only(bottom: 40),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    height: 22,
                    width: 4,
                    color: Colors.amber,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Progress",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: _theme.primaryColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Obx(() {
                  if (widget._notificationController.hiveRepository.result[0]
                          .id ==
                      0) {
                    return const Center(
                        child:
                            Text("Open Character's Drawer to Add Route Card"));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: widget
                        ._notificationController.hiveRepository.result.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        CharacterCard(index: index, item: widget.item)
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        backLayerBackgroundColor: _theme.accentColor,
        revealBackLayerAtStart: true,
        frontLayerActiveFactor: 0.5,
        frontLayerBackgroundColor: _theme.accentColor,
        subHeader: Container(
          color: _theme.primaryColorDark,
          child: Row(children: const [
            SizedBox(
              width: 16,
            ),
            BackdropToggleButton(
                color: Colors.white, icon: AnimatedIcons.menu_close),
            Text(
              "Character's Drawer",
              style: TextStyle(color: Colors.white),
            ),
          ]),
        ),
        frontLayer: Column(
          children: [
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
                  margin: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      children: widget.item.characters!
                          .asMap()
                          .entries
                          .map((e) {
                            if (e.value.vns[0][2] == 0) {
                              return ElevatedButton(
                                onPressed: () {
                                  Get.bottomSheet(
                                    CreateBottomSheet(
                                      e: e.value,
                                      vnID: widget.item.id,
                                      title: widget.item.title!,
                                    ),
                                    isScrollControlled: true,
                                  ).whenComplete(() {
                                    widget
                                        ._notificationController.hiveRepository
                                        .getCharactersRoute(widget.item.id);
                                    widget._notificationController.clearData();
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
                                        borderRadius:
                                            BorderRadius.circular(14))),
                                child: SizedBox(
                                    height: 100,
                                    width: 70,
                                    child: ClipRRect(
                                        child: FadeInImage.memoryNetwork(
                                            fit: BoxFit.cover,
                                            imageScale: 3,
                                            alignment: Alignment.topCenter,
                                            placeholder: kTransparentImage,
                                            image: e.value.image != null
                                                ? e.value.image!
                                                : ""))),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          })
                          .toList()
                          .cast<Widget>()),
                ),
              ),
            ),
          ],
        ));
  }

  String toDuration(String duration) {
    Duration playtime = DurationParsing.parseDuration(duration);
    String s = playtime.inHours.toString() +
        " hours " +
        playtime.inMinutes.toString() +
        " minute";
    return s;
  }
}
