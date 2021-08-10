import 'dart:developer';

import 'package:backdrop/scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/characters_repository.dart';
import 'package:visual_novel_strider/characters_widget.dart';
import 'package:visual_novel_strider/progress_fab.dart';
import 'package:visual_novel_strider/screens_widget.dart';
import 'package:visual_novel_strider/socket_server.dart';
import 'package:readmore/readmore.dart';
import 'package:visual_novel_strider/widgets/tags_widget.dart';

class VnDetail extends StatelessWidget {
  VnDetail({Key? key, required this.i}) : super(key: key);

  int i;

  @override
  Widget build(BuildContext context) {
    final SocketServer _controller = Get.find();
    final ThemeData _theme = Theme.of(context);
    final CharactersRepository _charactersRepository = Get.find();

    _charactersRepository.getCharacters(_controller.result!.value.items[i].id);

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
                        Container(
                            width: 130,
                            height: 170,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: (_controller.result!.value.items[i]
                                              .imageFlagging!.sexualAvg +
                                          _controller.result!.value.items[i]
                                              .imageFlagging!.violenceAvg ==
                                      0)
                                  ? FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: _controller
                                          .result!.value.items[i].image!,
                                      fit: BoxFit.cover,
                                    )
                                  : const Center(
                                      child: Text(
                                        "NSFW",
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                            )),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _controller.result!.value.items[i].title,
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
                                        _controller
                                            .result!.value.items[i].rating!
                                            .toString(),
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
                                        "#${_controller.result!.value.items[i].popularity}",
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
                                        _controller
                                            .result!.value.items[i].rating!
                                            .toString(),
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
                      _controller.result!.value.items[i].description != null
                          ? _controller.result!.value.items[i].description!
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
                        i: i,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ScreensWidget(
                        screenshot: _controller.result!.value.items[i].screens),
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
                    item: _controller.result!.value.items[i],
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
