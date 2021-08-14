import 'dart:developer';

import 'package:backdrop/backdrop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/model/hive_model/hive_model.dart';
import 'package:visual_novel_strider/model/item.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:visual_novel_strider/widgets/create_bottom_sheets.dart';

class DetailWidget extends StatefulWidget {
  DetailWidget({Key? key, required this.item}) : super(key: key);

  final HiveVNModel item;

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

    final List<Color> colors = [
      const Color(0xFFEAAEAE),
      const Color(0xFFB3BCEC),
      Color(0xFFE6A895),
      Colors.grey.shade400,
      Colors.orange.shade500,
    ];
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
          margin: EdgeInsets.only(bottom: 40),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    height: 22,
                    width: 4,
                    color: Colors.amber,
                  ),
                  SizedBox(
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
              SizedBox(
                height: 16,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 5,
                  itemBuilder: (context, index) => Column(
                    children: [
                      Column(
                        children: [
                          FractionallySizedBox(
                              widthFactor: 0.95,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    elevation: 4,
                                    padding: EdgeInsets.all(16),
                                    primary: colors[index],
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: FadeInImage.memoryNetwork(
                                              placeholder: kTransparentImage,
                                              fit: BoxFit.none,
                                              width: 60,
                                              height: 100,
                                              imageScale: 3,
                                              alignment: Alignment.topCenter,
                                              image: widget.item
                                                  .characters![index].image!),
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.item.characters![index]
                                                  .name!,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              widget.item.characters![index]
                                                  .original!,
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w300),
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
                                                  "Last Played",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.gamepad,
                                                  size: 14,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "Hours Played",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.gamepad,
                                                  size: 14,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "Progress: ",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      widget.item.characters![index]
                                                  .description !=
                                              null
                                          ? widget.item.characters![index]
                                              .description!
                                          : "No Description",
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 16,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
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
          child: Row(children: [
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
                  "The route count analysis may not be accurate!",
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
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 16, bottom: 16),
                    child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,
                        children: widget.item.characters!
                            .asMap()
                            .entries
                            .map((e) => ElevatedButton(
                                  onPressed: () {
                                    Get.bottomSheet(
                                      CreateBottomSheet(e: e.value),
                                      isScrollControlled: true,
                                    );
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
                                  child: Container(
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
                                ))
                            .toList()
                            .cast<Widget>()),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
