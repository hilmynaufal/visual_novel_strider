import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/characters_repository.dart';
import 'package:visual_novel_strider/controller&repository/detail_repository.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';
import 'package:visual_novel_strider/model/kana_model/individual_result.dart';
import 'package:visual_novel_strider/widgets/characters_widget.dart';
import 'package:readmore/readmore.dart';
import 'package:visual_novel_strider/widgets/progress_fab.dart';
import 'package:visual_novel_strider/widgets/release_info_page.dart';
import 'package:visual_novel_strider/widgets/screens_widget.dart';
import 'package:visual_novel_strider/widgets/vn_detail_header.dart';

import 'tags_widget.dart';

class VnDetail extends StatelessWidget {
  VnDetail(
      {Key? key, required this.id, required this.title, required this.image})
      : super(key: key);

  final CharactersRepository _charactersRepository =
      Get.put(CharactersRepository());
  final DetailRepository _detailRepository = Get.put(DetailRepository());

  final String id, title, image;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    _charactersRepository.getCharacters(id);
    _detailRepository.getDetail(id);

    return Scaffold(
        backgroundColor: theme.primaryColor,
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
                  color: theme.primaryColorLight,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RotatedBox(
                            quarterTurns: 1,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "DESCRIPTION",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.w200),
                                  ),
                                  Container(
                                    color: Colors.black,
                                    height: 2,
                                    width: 40,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(16),
                                  child: ReadMoreText(
                                    item.description != null
                                        ? item.description!
                                        : "No Description",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                    colorClickableText: theme.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 50,
                            child: TagsWidget(
                              tags: item.tags,
                              vnId: id,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ScreensWidget(screenshot: item.screenshots),
                          const SizedBox(
                            height: 16,
                          ),
                          CharactersWidget(
                              vnId: id, repository: _charactersRepository),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Get.to(() => ReleaseInfoPage(
                                          id: id,
                                          title: "Release",
                                          detailRepository: _detailRepository,
                                          subTitle:
                                              "This is the information of release of this visual novel:"));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        backgroundColor:
                                            theme.primaryColorLight,
                                        padding: const EdgeInsets.all(16),
                                        elevation: 4),
                                    child: const Column(
                                      children: [
                                        Icon(
                                          Icons.disc_full,
                                          size: 64,
                                        ),
                                        Text(
                                          "Release",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          )
                        ],
                      ),
                    ],
                  ),
                ))
              ]);
            } else {
              // _detailRepository.getDetail(id);
              return Container(
                width: double.infinity,
                color: theme.primaryColorLight,
                child: const Center(
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
          },
        ),
        floatingActionButton: Obx(() {
          if (_charactersRepository.isReady.isTrue &&
              _detailRepository.isReady.isTrue) {
            List<IndividualResult> individualResult = _charactersRepository
                .result.value.results
                .map((e) => e as IndividualResult)
                .toList();
            return ProgressFab(
                charaItem: individualResult,
                item: _detailRepository.detailResult.value.results[0]);
          } else {
            // _charactersRepository.getCharacters(id);
            return FloatingActionButton(
              backgroundColor: theme.primaryColor,
              onPressed: () {},
              child: CircularProgressIndicator(
                color: theme.primaryColorLight,
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
