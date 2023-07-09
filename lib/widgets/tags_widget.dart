import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/model/old_socket_model/item.dart';
import 'package:visual_novel_strider/model/old_socket_model/tags_result.dart';
import 'package:visual_novel_strider/widgets/vn_detail.dart';

import '../controller&repository/tags_repository.dart';
import '../model/kana_model/tag_result.dart';

class TagsWidget extends StatelessWidget {
  TagsWidget({Key? key, required this.tags}) : super(key: key);

  List<TagResult> tags;

  // final TagsRepository _tagsRepository = Get.find();

  @override
  Widget build(BuildContext context) {
    // _tagsRepository.getTags(item.tags!);

    final _theme = Theme.of(context);

    tags.sort((b, a) => a.rating.compareTo(b.rating));
    tags = tags
        .where(
          (e) => e.spoiler <= 1,
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 16),
              child: const Text("Tags",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  )),
            ),
            Container(
              margin: EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {
                  log("message");
                  Get.to(() => VnDetail(id: "v17", title: "title", image: ""));
                },
                child: Icon(
                  Icons.info_outline_rounded,
                  size: 16,
                  color: _theme.primaryColor,
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
                  itemCount: 8,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return Row(
                      children: [
                        index == 0
                            ? SizedBox(
                                width: 16,
                              )
                            : SizedBox(),
                        Container(
                          height: 18,
                          margin: EdgeInsets.only(right: 8),
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: _theme.primaryColor, width: 0.5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              onPressed: () {},
                              child: Text(
                                tags[index].name,
                                style: TextStyle(
                                    fontSize: 12, color: _theme.primaryColor),
                              )),
                        ),
                        index == 7
                            ? SizedBox(
                                width: 8,
                              )
                            : SizedBox(),
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
