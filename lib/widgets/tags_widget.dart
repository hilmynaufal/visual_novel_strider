import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/widgets/tag_info_bottomsheet.dart';

import '../model/kana_model/tag_result.dart';

// ignore: must_be_immutable
class TagsWidget extends StatelessWidget {
  TagsWidget({Key? key, required this.tags, required this.vnId})
      : super(key: key);

  List<TagResult> tags;
  final String vnId;

  // final TagsRepository _tagsRepository = Get.find();

  @override
  Widget build(BuildContext context) {
    // _tagsRepository.getTags(item.tags!);

    final theme = Theme.of(context);

    tags.sort((b, a) => a.rating.compareTo(b.rating));
    tags = tags
        .where(
          (e) => e.spoiler == 0,
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Container(
                  height: 22,
                  width: 4,
                  color: theme.primaryColor,
                ),
                const SizedBox(
                  width: 4,
                ),
                const Text(
                  "Tags",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {
                  log("message");
                  // Get.to(() => VnDetail(id: "v17", title: "title", image: ""));
                },
                child: Icon(
                  Icons.info_outline_rounded,
                  size: 16,
                  color: theme.primaryColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        tags.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  itemCount: tags.length < 8 ? tags.length : 8,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return Row(
                      children: [
                        index == 0
                            ? const SizedBox(
                                width: 16,
                              )
                            : const SizedBox(),
                        Container(
                          height: 18,
                          margin: const EdgeInsets.only(right: 8),
                          child: OutlinedButton(
                              onPressed: () {
                                Get.bottomSheet(TagInfoBottomsheet(id: vnId));
                              },
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: theme.primaryColor, width: 0.5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              child: Text(
                                tags[index].name,
                                style: TextStyle(
                                    fontSize: 12, color: theme.primaryColor),
                              )),
                        ),
                        index == 7
                            ? const SizedBox(
                                width: 8,
                              )
                            : const SizedBox(),
                      ],
                    );
                  },
                ),
              )
            : const Text("o"),
      ],
    );
  }
}
