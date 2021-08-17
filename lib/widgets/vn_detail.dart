import 'dart:developer';
import 'dart:ui';

import 'package:backdrop/scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/controller&repository/characters_repository.dart';
import 'package:visual_novel_strider/widgets/characters_widget.dart';
import 'package:visual_novel_strider/widgets/progress_fab.dart';
import 'package:visual_novel_strider/widgets/screens_widget.dart';
import 'package:visual_novel_strider/service/socket_server.dart';
import 'package:readmore/readmore.dart';
import 'package:visual_novel_strider/widgets/tags_widget.dart';

import '../model/item.dart';

class VnDetail extends StatelessWidget {
  VnDetail({Key? key, required this.item}) : super(key: key);

  final SocketServer _controller = Get.find();

  final CharactersRepository _charactersRepository = Get.find();

  final Item item;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    _charactersRepository.getCharacters(item.id);

    return (BackdropScaffold(
        backLayer: Container(),
        appBar: AppBar(
          backgroundColor: _theme.primaryColor,
          elevation: 0,
          title: Row(
            children: [
              Icon(CupertinoIcons.bolt),
              Text(
                "Details",
                style: TextStyle(
                    color: _theme.accentColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        frontLayer: _controller.isReady
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          clipBehavior: Clip.antiAlias,
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(0),
                          ),
                          child: Container(
                              width: 130,
                              height: 170,
                              child: (item.imageFlagging!.sexualAvg +
                                          item.imageFlagging!.violenceAvg ==
                                      0)
                                  ? FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: item.image!,
                                      fit: BoxFit.cover,
                                    )
                                  : const Center(
                                      child: Text(
                                        "NSFW",
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    )),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.title,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 20,
                                        color: _theme.primaryColor,
                                      ),
                                      Text(
                                        item.rating!.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "#${item.popularity}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text("Popularity")
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 20,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        item.rating!.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(height: 1, color: Colors.grey.shade200),
                    const SizedBox(height: 8),
                    const Text("Description",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )),
                    const SizedBox(height: 8),
                    ReadMoreText(
                      item.description != null
                          ? item.description!
                          : "No Description",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      colorClickableText: _theme.primaryColor,
                    ),
                    const SizedBox(height: 16),
                    Container(height: 1, color: Colors.grey.shade200),
                    const SizedBox(height: 24),
                    Container(
                      height: 20,
                      child: TagsWidget(
                        item: item,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ScreensWidget(screenshot: item.screens),
                    const SizedBox(
                      height: 20,
                    ),
                    CharactersWidget(),
                  ],
                ),
              )
            : const LinearProgressIndicator(),
        floatingActionButton: Obx(
          () {
            return _charactersRepository.result.value.num != 0
                ? ProgressFab(
                    item: item,
                    charaItem: _charactersRepository.result.value.charaItems!)
                : FloatingActionButton(
                    backgroundColor: _theme.primaryColor,
                    onPressed: () {},
                    child: CircularProgressIndicator(
                      color: _theme.accentColor,
                    ),
                  );
          },
        )));
  }
}
