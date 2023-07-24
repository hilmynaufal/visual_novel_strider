// ignore_for_file: prefer_const_constructors

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Most played Visual novel around the world".toUpperCase(),
                  maxLines: 2,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                ),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 16,
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
                height: 16,
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _repository.popularResult.value.results.length,
                  itemBuilder: (BuildContext context, int index) {
                    Result _e = _repository.popularResult.value.results[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => VnDetail(
                              id: _e.id,
                              image: _e.image.url,
                              title: _e.title,
                            ));
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              itemSettings(index, _e),
                              SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  _repository
                                      .popularResult.value.results[index].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    CupertinoIcons.star_fill,
                                    size: 10,
                                    color: _theme.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    _e.rating.toString(),
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              )
                            ],
                          ),
                          index ==
                                  _repository
                                          .popularResult.value.results.length -
                                      1
                              ? SizedBox(
                                  width: 16,
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

  Stack itemSettings(int index, Result _e) {
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
      ElevatedButton(
        onPressed: () {
          Get.to(() => VnDetail(
                id: _e.id,
                image: _e.image.url,
                title: _e.title,
              ));
        },
        clipBehavior: Clip.antiAlias,
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          padding: EdgeInsets.all(0),
        ),
        child: SizedBox(
          height: 130,
          width: 100,
          child: _imageRating <= 1
              ? FancyShimmerImage(
                  shimmerBaseColor: Colors.grey[300],
                  shimmerHighlightColor: Colors.grey[100],
                  boxFit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  imageUrl:
                      _repository.popularResult.value.results[index].image.url)
              : Center(
                  child: NSFWWidget(),
                ),
        ),
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
