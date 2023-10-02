// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
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
    var theme = Theme.of(context);

    return Container(
      color: theme.primaryColorLight,
      child: GetBuilder<HiveRepository>(
        builder: (repository) {
          repository.getItem();
          if (repository.isReady.isTrue) {
            return ListView.builder(
              itemCount: repository.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      // padding:
                      //     EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            splashFactory: NoSplash.splashFactory,
                            elevation: 0,
                            padding: const EdgeInsets.all(0),
                            primary: theme.primaryColorLight,
                            onPrimary: Colors.black),
                        onPressed: () {
                          Get.to(() =>
                              DetailWidget(item: repository.data![index]));
                        },
                        onLongPress: () {
                          Get.bottomSheet(
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                      if (repository.data![index].isComplete!) {
                                        repository.data![index].isComplete =
                                            false;
                                      } else {
                                        repository.data![index].isComplete =
                                            true;
                                      }
                                      repository.data![index].save();
                                      repository.update();
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          16, 8, 0, 0),
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
                                            repository.data![index].isComplete!
                                                ? "Mark Playing"
                                                : "Mark Completed",
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
                                      repository.data![index].delete();
                                      repository.update();
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          16, 8, 0, 0),
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
                              ),
                              backgroundColor: theme.primaryColor);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.all(4),
                              color: Colors.grey[200],
                              child: SizedBox(
                                height: 140,
                                width: 100,
                                child: (repository.data![index].image?.sexual +
                                            repository
                                                .data![index].image?.violence ==
                                        0)
                                    ? FadeInImage.memoryNetwork(
                                        placeholder: kTransparentImage,
                                        imageScale: 3,
                                        image:
                                            repository.data![index].image!.url,
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
                                    color: repository.data![index].isComplete!
                                        ? theme.primaryColor
                                        : Colors.yellow.shade900,
                                    child: Text(
                                      repository.data![index].isComplete!
                                          ? "Completed".toUpperCase()
                                          : "Playing".toUpperCase(),
                                      style: TextStyle(
                                          color: theme.primaryColorLight,
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
                                          repository.data![index].title,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          repository.data![index].alttitle ??
                                              repository.data![index].title,
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
                                                          color: theme
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
                                                    repository.data![index]
                                                            .olang!.isNotEmpty
                                                        ? repository
                                                            .data![index].olang!
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
                                                  color: theme.primaryColor,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  repository
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
                                                  color: theme.primaryColor,
                                                ),
                                                Text(
                                                  repository.data![index].rating
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
                                    color: theme.primaryColor,
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
