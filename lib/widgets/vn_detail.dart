// ignore_for_file: deprecated_member_use, sized_box_for_whitespace

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/controller&repository/characters_repository.dart';
import 'package:visual_novel_strider/utils/length_convert.dart';
import 'package:visual_novel_strider/widgets/characters_widget.dart';
import 'package:visual_novel_strider/widgets/progress_fab.dart';
import 'package:visual_novel_strider/widgets/screens_widget.dart';
import 'package:readmore/readmore.dart';
import 'package:visual_novel_strider/widgets/tags_widget.dart';

import '../model/item.dart';

class VnDetail extends StatelessWidget {
  VnDetail({Key? key, required this.item}) : super(key: key);

  final CharactersRepository _charactersRepository = Get.find();

  final Item item;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    _charactersRepository.getCharacters(item.id);

    return Scaffold(
        backgroundColor: _theme.primaryColor,
        body: CustomScrollView(slivers: [
          SliverAppBar(
            backgroundColor: _theme.primaryColor,
            elevation: 2,
            pinned: true,
            expandedHeight: 200,
            title: Text(
              item.title,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                alignment: Alignment.center,
                image: item.image!,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(
              () => (_charactersRepository.isReady.value &&
                      _charactersRepository.releaseResult.value.num != 0)
                  ? Container(
                      color: _theme.accentColor,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                      clipBehavior: Clip.antiAlias,
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        padding: const EdgeInsets.all(0),
                                      ),
                                      child: SizedBox(
                                          width: 130,
                                          height: 170,
                                          child: (item.imageFlagging!
                                                          .sexualAvg +
                                                      item.imageFlagging!
                                                          .violenceAvg <=
                                                  2)
                                              ? FadeInImage.memoryNetwork(
                                                  placeholder:
                                                      kTransparentImage,
                                                  image: item.image!,
                                                  fit: BoxFit.cover,
                                                )
                                              : const Center(
                                                  child: Text(
                                                    "NSFW",
                                                    style:
                                                        TextStyle(fontSize: 22),
                                                  ),
                                                )),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            item.title,
                                            maxLines: 3,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(item.original ?? item.title,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w300)),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text("by "),
                                              Text(
                                                _charactersRepository
                                                    .releaseResult
                                                    .value
                                                    .items![0]
                                                    .producers![0]
                                                    .name,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
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
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 14,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    item.length != null
                                                        ? LengthConvert
                                                            .intLengthtoString(
                                                                item.length!)
                                                        : "No Record",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  const Text(
                                                    "Playtime",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "#${item.popularity}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  const Text(
                                                    "Popularity",
                                                    style:
                                                        TextStyle(fontSize: 11),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Container(
                                    height: 1, color: Colors.grey.shade200),
                                const SizedBox(height: 16),
                                const Text("Description",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    )),
                                const SizedBox(height: 8),
                                ReadMoreText(
                                  item.description != null
                                      ? item.description!
                                      : "No Description",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5),
                                  colorClickableText: _theme.primaryColor,
                                ),
                                const SizedBox(height: 16),
                                Container(
                                    height: 1, color: Colors.grey.shade200),
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
                                  height: 30,
                                ),
                                CharactersWidget(),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    )
                  : Container(
                      child: Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                          width: 60,
                          height: 60,
                        ),
                      ),
                      width: double.infinity,
                      color: _theme.accentColor,
                    ),
            ),
          ),
        ]),
        floatingActionButton: Obx(
          () {
            return _charactersRepository.isReady.value
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
        ));
  }
}
