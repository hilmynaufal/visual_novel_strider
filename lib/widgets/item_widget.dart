// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/controller&repository/search_repository.dart';
import 'package:visual_novel_strider/utils/datetime_parse.dart';
import 'package:visual_novel_strider/widgets/text/nsfw_widget.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    var _splashColor = _theme.primaryColorLight;

    return GetBuilder<SearchRepository>(
        builder: (_controller) => Expanded(
              child: ListView.builder(
                  itemCount: _controller.searchResult.value.results.length,
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          // Get.to(() => VnDetail(
                          //       item: _controller.searchResult.value.results[index],
                          //     ));
                        },
                        splashColor: _splashColor,
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
                                    child: (_controller
                                                    .searchResult
                                                    .value
                                                    .results[index]
                                                    .image
                                                    .sexual +
                                                _controller
                                                    .searchResult
                                                    .value
                                                    .results[index]
                                                    .image
                                                    .violence ==
                                            0)
                                        ? FadeInImage.memoryNetwork(
                                            placeholder: kTransparentImage,
                                            image: _controller.searchResult
                                                .value.results[index].image.url,
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
                                        _controller.searchResult.value
                                            .results[index].title,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        _controller.searchResult.value
                                                .results[index].alttitle ??
                                            _controller.searchResult.value
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
                                            itemCount: _controller
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
                                                              color: _theme
                                                                  .primaryColor,
                                                              width: 1),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                      onPressed: () {},
                                                      child: Text(
                                                        _controller
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
                                            color: _theme.primaryColor,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            _controller
                                                    .searchResult
                                                    .value
                                                    .results[index]
                                                    .released
                                                    .isNotEmpty
                                                ? DateTimeParse.parseDateTime(
                                                    _controller
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
                                            color: _theme.primaryColor,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            _controller.searchResult.value
                                                .results[index].rating
                                                .toString(),
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
