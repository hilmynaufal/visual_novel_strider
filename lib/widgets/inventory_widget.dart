// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/controller&repository/hive_repository.dart';

import 'detail_widget.dart';

class InventoryWidget extends StatefulWidget {
  const InventoryWidget({Key? key}) : super(key: key);

  @override
  State<InventoryWidget> createState() => _InventoryWidgetState();
}

class _InventoryWidgetState extends State<InventoryWidget> {
  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);

    return Container(
      color: _theme.accentColor,
      child: GetBuilder<HiveRepository>(
        builder: (_repository) {
          _repository.getItem();
          if (_repository.isReady) {
            return ListView.builder(
              itemCount: _repository.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        clipBehavior: Clip.hardEdge,
                        style: ElevatedButton.styleFrom(
                            splashFactory: NoSplash.splashFactory,
                            elevation: 4,
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: _theme.primaryColor, width: 0),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            primary: _theme.accentColor,
                            onPrimary: Colors.black),
                        onPressed: () {
                          Get.to(() =>
                              DetailWidget(item: _repository.data![index]));
                        },
                        onLongPress: () {
                          Get.bottomSheet(
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                      if (_repository
                                          .data![index].isComplete!) {
                                        _repository.data![index].isComplete =
                                            false;
                                        _repository.data![index].save();
                                      } else {
                                        _repository.data![index].isComplete =
                                            true;
                                      }
                                      _repository.update();
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          16, 8, 0, 0),
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
                                            _repository.data![index].isComplete!
                                                ? "Mark Playing"
                                                : "Mark Completed",
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
                                      _repository.data![index].delete();
                                      _repository.update();
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          16, 8, 0, 0),
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
                              ),
                              backgroundColor: _theme.primaryColor);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 140,
                              width: 100,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                child: (_repository.data![index].imageFlagging!
                                                .sexualAvg +
                                            _repository.data![index]
                                                .imageFlagging!.violenceAvg ==
                                        0)
                                    ? FadeInImage.memoryNetwork(
                                        placeholder: kTransparentImage,
                                        imageScale: 3,
                                        image: _repository.data![index].image!,
                                        fit: BoxFit.cover,
                                      )
                                    : const Center(
                                        child: Text(
                                          "NSFW",
                                          style: TextStyle(fontSize: 30),
                                        ),
                                      ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    color: _repository.data![index].isComplete!
                                        ? _theme.primaryColor
                                        : Colors.yellow.shade900,
                                    child: Text(
                                      _repository.data![index].isComplete!
                                          ? "Completed".toUpperCase()
                                          : "Playing".toUpperCase(),
                                      style: TextStyle(
                                          color: _theme.accentColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11),
                                    ),
                                  ),
                                  Container(
                                    height: 121,
                                    margin: const EdgeInsets.only(left: 16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _repository.data![index].title!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          _repository.data![index].original ??
                                              _repository.data![index].title,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 8, bottom: 8, top: 8),
                                              height: 18,
                                              width: 60,
                                              child: OutlinedButton(
                                                  style: OutlinedButton.styleFrom(
                                                      side: BorderSide(
                                                          color: _theme
                                                              .primaryColor,
                                                          width: 1),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30))),
                                                  onPressed: () {},
                                                  child: Text(
                                                    _repository
                                                            .data![index]
                                                            .origLang!
                                                            .isNotEmpty
                                                        ? _repository
                                                            .data![index]
                                                            .origLang![0]
                                                            .toUpperCase()
                                                        : "JA",
                                                    style: TextStyle(
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  size: 16,
                                                  color: _theme.primaryColor,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  _repository
                                                      .data![index].released!,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 11),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: _theme.primaryColor,
                                                ),
                                                Text(
                                                  _repository
                                                      .data![index].rating
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w100,
                                                    fontSize: 11,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  LinearProgressIndicator(
                                    backgroundColor: Colors.grey[100],
                                    color: _theme.primaryColor,
                                    minHeight: 4,
                                    value: 0.2,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return Text("no data");
        },
      ),
    );
  }
}
