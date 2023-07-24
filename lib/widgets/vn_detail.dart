// ignore_for_file: deprecated_member_use, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/characters_repository.dart';
import 'package:visual_novel_strider/controller&repository/detail_repository.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';
import 'package:visual_novel_strider/model/kana_model/individual_result.dart';
import 'package:visual_novel_strider/utils/length_convert.dart';
import 'package:visual_novel_strider/widgets/characters_widget.dart';
import 'package:readmore/readmore.dart';
import 'package:visual_novel_strider/widgets/progress_fab.dart';
import 'package:visual_novel_strider/widgets/screens_widget.dart';
import 'package:visual_novel_strider/widgets/vn_detail_header.dart';

import 'tags_widget.dart';

class VnDetail extends StatelessWidget {
  VnDetail(
      {Key? key, required this.id, required this.title, required this.image})
      : super(key: key);

  final CharactersRepository _charactersRepository = Get.find();
  final DetailRepository _detailRepository = Get.find();

  final String id, title, image;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    _charactersRepository.getCharacters(id);
    _detailRepository.getDetail(id);

    return Scaffold(
        backgroundColor: _theme.primaryColor,
        body: Obx(
          () {
            if (_detailRepository.detailResult.value.results.isNotEmpty) {
              DetailResult item =
                  _detailRepository.detailResult.value.results[0];
              return CustomScrollView(slivers: [
                VNDetailHeader(
                  image: image,
                  title: title,
                  item: item,
                  tabController: null,
                ),
                SliverToBoxAdapter(
                    child: Container(
                  color: _theme.accentColor,
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                item.length != null
                                    ? LengthConvert.intLengthtoString(
                                        item.length!)
                                    : "No Record",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                ),
                              ),
                              const Text(
                                "Playtime",
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "#" + item.popularity!.round().toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                              ),
                              const Text(
                                "Popularity",
                                style: TextStyle(fontSize: 11),
                              )
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(16),
                        child: ReadMoreText(
                          item.description != null
                              ? item.description!
                              : "No Description",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          colorClickableText: _theme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        child: TagsWidget(tags: item.tags),
                        height: 50,
                      ),
                      const SizedBox(height: 16),
                      ScreensWidget(screenshot: item.screenshots),
                      const SizedBox(
                        height: 30,
                      ),
                      CharactersWidget(vnId: id),
                    ],
                  ),
                ))
              ]);
            } else {
              // _detailRepository.getDetail(id);
              return Container(
                child: Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                ),
                width: double.infinity,
                color: _theme.accentColor,
              );
            }
          },
        ),
        floatingActionButton: Obx(() {
          if (_charactersRepository.isReady.isTrue &&
              _detailRepository.isReady.isTrue) {
            List<IndividualResult> _individualResult = _charactersRepository
                .result.value.results
                .map((e) => e as IndividualResult)
                .toList();
            return ProgressFab(
                charaItem: _individualResult,
                item: _detailRepository.detailResult.value.results[0]);
          } else {
            // _charactersRepository.getCharacters(id);
            return FloatingActionButton(
              backgroundColor: _theme.primaryColor,
              onPressed: () {},
              child: CircularProgressIndicator(
                color: _theme.accentColor,
              ),
            );
          }
        })
        // return _charactersRepository.isReady.value
        // ? ProgressFab(
        //     item: item,
        //     charaItem: _charactersRepository.result.value.charaItems!)
        );
  }
}
