// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/home_repository.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:visual_novel_strider/widgets/text/nsfw_widget.dart';
import 'package:visual_novel_strider/widgets/vn_detail.dart';

import '../model/kana_model/result.dart';

class LatestWidget extends StatelessWidget {
  LatestWidget({Key? key}) : super(key: key);

  final HomeRepository _repository = Get.find();
  // final KanaServer _kanaRepo = Get.find();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Obx(() {
      if (_repository.result.value.results.isNotEmpty) {
        return Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                Container(
                  height: 22,
                  width: 4,
                  color: _theme.primaryColor,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "Latest Release",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _repository.result.value.results.length,
                itemBuilder: (BuildContext context, int index) {
                  dynamic _imageRating = _repository
                          .result.value.results[index].image.sexual +
                      _repository.result.value.results[index].image.violence;
                  return Row(
                    children: [
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Result _e = _repository.result.value.results[index];
                          Get.to(() => VnDetail(
                                id: _e.id,
                                image: _e.image.url,
                                title: _e.title,
                              ));
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 130,
                              width: 100,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10)),
                              child: _imageRating <= 1
                                  ? FancyShimmerImage(
                                      shimmerBaseColor: Colors.grey[300],
                                      shimmerHighlightColor: Colors.grey[100],
                                      boxFit: BoxFit.cover,
                                      imageUrl: _repository.result.value
                                          .results[index].image.url)
                                  : Center(
                                      child: NSFWWidget(),
                                    ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                  _repository.result.value.results[index].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  )),
                            )
                          ],
                        ),
                      ),
                      index == _repository.result.value.results.length - 1
                          ? SizedBox(
                              width: 8,
                            )
                          : SizedBox()
                    ],
                  );
                },
              ),
            ),
          ],
        );
      } else {
        _repository.getNewReleased();
        return CircularProgressIndicator();
      }
    });
  }
}
