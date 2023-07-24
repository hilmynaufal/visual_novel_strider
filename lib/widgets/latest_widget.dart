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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "update your game".toUpperCase(),
                maxLines: 2,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 16,
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
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _repository.result.value.results.length,
                itemBuilder: (BuildContext context, int index) {
                  dynamic _imageRating = _repository
                          .result.value.results[index].image.sexual +
                      _repository.result.value.results[index].image.violence;
                  return Row(
                    children: [
                      SizedBox(width: 16),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Result _e =
                                  _repository.result.value.results[index];
                              Get.to(() => VnDetail(
                                    id: _e.id,
                                    image: _e.image.url,
                                    title: _e.title,
                                  ));
                            },
                            clipBehavior: Clip.antiAlias,
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                elevation: 4,
                                padding: EdgeInsets.all(0),
                                primary: Theme.of(context).accentColor),
                            child: SizedBox(
                              height: 130,
                              width: 100,
                              child: _imageRating <= 1
                                  ? FancyShimmerImage(
                                      shimmerBaseColor: Colors.grey[300],
                                      shimmerHighlightColor: Colors.grey[100],
                                      boxFit: BoxFit.cover,
                                      alignment: Alignment.topCenter,
                                      imageUrl: _repository.result.value
                                          .results[index].image.url)
                                  : Center(
                                      child: NSFWWidget(),
                                    ),
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
