// ignore_for_file: prefer_const_constructors

import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/controller&repository/home_repository.dart';
import 'package:visual_novel_strider/widgets/latest_widget.dart';
import 'package:visual_novel_strider/widgets/popular_widget.dart';

class HomeWidget extends StatelessWidget {
  HomeWidget({Key? key}) : super(key: key);

  final HomeRepository _repository = Get.put(HomeRepository());

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    if (_repository.result.value.num == 0 ||
        _repository.popularResult.value.num == 0) _repository.getNewReleased();

    return Container(
        child: Column(
      children: [
        SizedBox(
          height: 16,
        ),
        LatestWidget(),
        SizedBox(
          height: 1,
        ),
        PopularWidget()
      ],
    ));
  }
}
