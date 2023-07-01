// ignore_for_file: prefer_const_constructors

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/home_repository.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';
import 'package:visual_novel_strider/widgets/text/nsfw_widget.dart';
import 'package:visual_novel_strider/widgets/vn_detail.dart';

import '../model/kana_model/result.dart';

class PopularWidget extends StatelessWidget {
  PopularWidget({Key? key}) : super(key: key);

  final HomeRepository _repository = Get.find();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Obx(
      () {
        if (_repository.popularResult.value.results.isNotEmpty) {
          return Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    height: 22,
                    width: 4,
                    color: _theme.primaryColor,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Most Popular",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _repository.popularResult.value.results.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Result _result =
                            _repository.popularResult.value.results[index];
                        Get.to(() => VnDetail(
                              id: _result.id,
                              image: _result.image.url,
                              title: _result.title,
                            ));
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 8),
                          Column(
                            children: [
                              itemSettings(index),
                              SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  _repository
                                      .popularResult.value.results[index].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          index ==
                                  _repository
                                          .popularResult.value.results.length -
                                      1
                              ? SizedBox(
                                  width: 8,
                                )
                              : SizedBox()
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          _repository.getMostPopular();
          return CircularProgressIndicator();
        }
      },
    );
  }

  Stack itemSettings(int index) {
    String? _image = _repository.popularResult.value.results[index].image.url;
    dynamic _imageRating =
        (_repository.popularResult.value.results[index].image.sexual +
            _repository.popularResult.value.results[index].image.violence);
    Color _background, _surface;
    switch (index + 1) {
      case 1:
        {
          _background = Colors.amber[300]!;
          _surface = Colors.black;
          break;
        }
      case 2:
        {
          _background = Colors.grey[300]!;
          _surface = Colors.black;
          break;
        }
      case 3:
        {
          _background = Colors.brown[400]!;
          _surface = Colors.white;
          break;
        }
      default:
        {
          _background = Colors.black87;
          _surface = Colors.white;
        }
    }
    return Stack(children: [
      Container(
        height: 130,
        width: 100,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade200),
        child: _imageRating >= 2
            ? Center(
                child: NSFWWidget(),
              )
            : FancyShimmerImage(
                shimmerBaseColor: Colors.grey[300],
                shimmerHighlightColor: Colors.grey[100],
                boxFit: BoxFit.cover,
                imageUrl: _image!),
      ),
      Positioned(
          child: Container(
        child: Center(
          child: Text(
            "#${(index + 1).toString()}",
            style: TextStyle(color: _surface, fontWeight: FontWeight.bold),
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            color: _background),
        height: 20,
        width: 40,
      ))
    ]);
  }
}
