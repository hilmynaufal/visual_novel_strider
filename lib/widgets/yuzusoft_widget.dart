import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/home_repository.dart';
import 'package:visual_novel_strider/widgets/text/nsfw_widget.dart';
import 'package:visual_novel_strider/widgets/vn_detail.dart';

import '../model/kana_model/result.dart';

class YuzusoftWidget extends StatelessWidget {
  YuzusoftWidget({Key? key}) : super(key: key);

  final HomeRepository _repository = Get.find();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Obx(
      () {
        if (_repository.yuzusoftResult.value.results.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "A story of an emotional impact".toUpperCase(),
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w300),
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
                  const Text(
                    "Developer Selection",
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
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    // padding: EdgeInsets.only(bottom: 40),
                    margin: EdgeInsets.only(bottom: 130),
                    color: Colors.amber,
                    width: double.infinity,
                    height: 100,
                    alignment: Alignment.topCenter,
                  ),
                  Positioned(
                    child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            _repository.yuzusoftResult.value.results.length,
                        itemBuilder: (BuildContext context, int index) {
                          Result _e =
                              _repository.yuzusoftResult.value.results[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              index == 0
                                  ? Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                            shape: BoxShape.circle),
                                        padding: EdgeInsets.all(4),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: ClipOval(
                                          child: SizedBox.fromSize(
                                            size: Size.fromRadius(60),
                                            child: Image.asset(
                                              'assets/yuzusoft_logo.jpg',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(width: 16),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => VnDetail(
                                      id: _e.id,
                                      title: _e.title,
                                      image: _e.image.url));
                                },
                                child: Column(
                                  children: [
                                    itemSettings(index, _e),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                          _repository.yuzusoftResult.value
                                              .results[index].title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              index ==
                                      _repository.yuzusoftResult.value.results
                                              .length -
                                          1
                                  ? const SizedBox(
                                      width: 8,
                                    )
                                  : const SizedBox()
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          _repository.getYuzusoft();
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget itemSettings(int index, Result _e) {
    String? _image = _repository.yuzusoftResult.value.results[index].image.url;
    dynamic _imageRating =
        (_repository.yuzusoftResult.value.results[index].image.sexual +
            _repository.yuzusoftResult.value.results[index].image.violence);
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
          Get.to(
              () => VnDetail(id: _e.id, title: _e.title, image: _e.image.url));
        },
        clipBehavior: Clip.antiAlias,
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          padding: const EdgeInsets.all(0),
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
                      _repository.yuzusoftResult.value.results[index].image.url)
              : const Center(
                  child: const NSFWWidget(),
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
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            color: _background),
        height: 20,
        width: 40,
      ))
    ]);
  }
}
