import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/detail_repository.dart';
import 'package:visual_novel_strider/model/kana_model/release_result.dart';
import 'package:visual_novel_strider/utils/datetime_parse.dart';
import 'package:visual_novel_strider/widgets/route_detail_widget/abstract_route_settings.dart';

class ReleaseInfoPage extends AbstractSimpleMonochromePage {
  ReleaseInfoPage(
      {super.key,
      required this.id,
      required super.title,
      required super.subTitle,
      required this.detailRepository})
      : super(scrollController: ScrollController());
  final String id;
  final DetailRepository detailRepository;

  @override
  Widget build(BuildContext context) {
    scrollController!.addListener(
      () {
        if (scrollController!.position.maxScrollExtent ==
                scrollController!.offset &&
            detailRepository.releaseResult.value.more &&
            detailRepository.isReleaseReady.isTrue) {
          log("scroll controller listener attached");
          detailRepository.getReleaseDetail(id);
        }
      },
    );
    return buildWidget(context, body: [
      GetBuilder<DetailRepository>(
        builder: (repo) {
          if (repo.releaseResult.value.results.isEmpty) {
            repo.getReleaseDetail(id);
            return const SizedBox();
          }
          return ListView.builder(
            itemCount: repo.releaseResult.value.results.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final release =
                  repo.releaseResult.value.results[index] as ReleaseResult;
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.all(8),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          release.title,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline),
                        ),
                        Wrap(children: [
                          ...release.producers
                              .map(
                                (e) => Text(
                                  "$e   ",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                              )
                              .cast<Widget>()
                              .toList(),
                          Text(
                            DateTimeParse.parseDateTime(release.released),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                        ]),
                        Row(
                          children: [
                            Text(
                              release.languages[0].toUpperCase(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w200, fontSize: 12),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              "Windows",
                              style: TextStyle(
                                  fontWeight: FontWeight.w200, fontSize: 12),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              release.rtype[0].capitalizeFirst!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w200, fontSize: 12),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            !release.official
                                ? const Text(
                                    "Unofficial",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 12),
                                  )
                                : const SizedBox()
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              release.minage != 0 && release.minage != null
                                  ? "${release.minage}+"
                                  : "All-ages",
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Icon(
                              CupertinoIcons.tv_fill,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Icon(
                              CupertinoIcons.cloud_download_fill,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            release.voiced != 0 && release.voiced != null
                                ? const Icon(
                                    CupertinoIcons.mic_fill,
                                    size: 16,
                                  )
                                : const SizedBox()
                          ],
                        )
                      ],
                    )),
              );
            },
          );
        },
      ),
      Obx(() => detailRepository.isReleaseReady.isTrue
          ? const SizedBox()
          : const LinearProgressIndicator())
    ]);
  }
}
