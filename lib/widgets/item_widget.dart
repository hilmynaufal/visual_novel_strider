// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/controller&repository/search_repository.dart';
import 'package:visual_novel_strider/utils/datetime_parse.dart';
import 'package:visual_novel_strider/widgets/text/nsfw_widget.dart';
import 'package:visual_novel_strider/widgets/vn_detail.dart';

import '../model/kana_model/result.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    var splashColor = theme.primaryColorLight;

    return GetBuilder<SearchRepository>(
        builder: (controller) => Expanded(
              child: ListView.builder(
                  itemCount: controller.searchResult.value.results.length,
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          log("message");
                          Result e =
                              controller.searchResult.value.results[index];

                          Get.to(() => VnDetail(
                                id: e.id,
                                image: e.image.url,
                                title: e.title,
                              ));
                        },
                        splashColor: splashColor,
                        child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 16),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  clipBehavior: Clip.antiAlias,
                                  style: ElevatedButton.styleFrom(
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.all(0)),
                                  onPressed: () {},
                                  child: SizedBox(
                                    height: 100,
                                    width: 70,
                                    child: (controller
                                                    .searchResult
                                                    .value
                                                    .results[index]
                                                    .image
                                                    .sexual +
                                                controller
                                                    .searchResult
                                                    .value
                                                    .results[index]
                                                    .image
                                                    .violence ==
                                            0)
                                        ? FadeInImage.memoryNetwork(
                                            placeholder: kTransparentImage,
                                            image: controller.searchResult.value
                                                .results[index].image.url,
                                            fit: BoxFit.cover,
                                          )
                                        : const Center(
                                            child: NSFWWidget(),
                                          ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.searchResult.value
                                            .results[index].title,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        controller.searchResult.value
                                                .results[index].alttitle ??
                                            controller.searchResult.value
                                                .results[index].title,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      SizedBox(
                                        height: 20,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: controller
                                                .searchResult
                                                .value
                                                .results[index]
                                                .languages
                                                .length,
                                            itemBuilder: (_, langIndex) =>
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(right: 4),
                                                  height: 18,
                                                  width: 60,
                                                  child: OutlinedButton(
                                                      style: OutlinedButton.styleFrom(
                                                          side: BorderSide(
                                                              color: theme
                                                                  .primaryColor,
                                                              width: 1),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                      onPressed: () {},
                                                      child: Text(
                                                        controller
                                                            .searchResult
                                                            .value
                                                            .results[index]
                                                            .languages[
                                                                langIndex]
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 8,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )),
                                                )),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month_rounded,
                                            size: 18,
                                            color: theme.primaryColor,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            controller
                                                    .searchResult
                                                    .value
                                                    .results[index]
                                                    .released
                                                    .isNotEmpty
                                                ? DateTimeParse.parseDateTime(
                                                    controller
                                                        .searchResult
                                                        .value
                                                        .results[index]
                                                        .released)
                                                : "None",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star_rate_rounded,
                                            size: 18,
                                            color: theme.primaryColor,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            controller
                                                        .searchResult
                                                        .value
                                                        .results[index]
                                                        .rating !=
                                                    null
                                                ? controller.searchResult.value
                                                    .results[index].rating
                                                    .toString()
                                                : "No Rating",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            "/10",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w100,
                                              fontSize: 12,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                      )),
            ));
  }
}
