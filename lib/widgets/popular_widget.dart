import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/home_repository.dart';

class PopularWidget extends StatelessWidget {
  PopularWidget({Key? key}) : super(key: key);

  final HomeRepository _repository = Get.find();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Obx(
      () {
        if (_repository.popularResult.value.num != 0) {
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
                    "Most Popular",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
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
                  itemCount: _repository.popularResult.value.num,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        SizedBox(width: 8),
                        Column(
                          children: [
                            itemSettings(index),
                            Container(
                              width: 100,
                              child: Text(
                                _repository
                                    .popularResult.value.items[index].title,
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

  Stack itemSettings(int index) {
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FancyShimmerImage(
              shimmerBaseColor: Colors.grey[300],
              shimmerHighlightColor: Colors.grey[100],
              boxFit: BoxFit.cover,
              imageUrl: _repository.popularResult.value.items[index].image!),
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
