// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/home_repository.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

class LatestWidget extends StatelessWidget {
  LatestWidget({Key? key}) : super(key: key);

  final HomeRepository _repository = Get.find();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Obx(
      () {
        if (_repository.result.value.num != 0) {
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
                    color: Colors.amber,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Latest Release",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: _theme.primaryColor),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _repository.result.value.num,
                  itemBuilder: (BuildContext context, int index) {
                    dynamic _imageRating = _repository.result.value.items[index]
                            .imageFlagging!.sexualAvg +
                        _repository.result.value.items[index].imageFlagging!
                            .violenceAvg;
                    return Row(
                      children: [
                        SizedBox(width: 8),
                        Column(
                          children: [
                            Container(
                              height: 130,
                              width: 100,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10)),
                              child: _imageRating == 0
                                  ? FancyShimmerImage(
                                      shimmerBaseColor: Colors.grey[300],
                                      shimmerHighlightColor: Colors.grey[100],
                                      boxFit: BoxFit.cover,
                                      imageUrl: _repository
                                          .result.value.items[index].image!)
                                  : Center(
                                      child: Text(
                                        "NSFW",
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                            ),
                            Container(
                              width: 100,
                              child: Text(
                                _repository.result.value.items[index].title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
