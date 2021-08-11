import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/home_repository.dart';
import 'package:visual_novel_strider/widgets/latest_widget.dart';
import 'package:visual_novel_strider/widgets/popular_widget.dart';

class HomeWidget extends StatelessWidget {
  HomeWidget({Key? key}) : super(key: key);

  final HomeRepository _repository = Get.put(HomeRepository());

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    _repository.getNewReleased();
    _repository.getMostPopular();

    return BackdropScaffold(
        frontLayerBackgroundColor: _theme.accentColor,
        appBar: BackdropAppBar(
          title: Text("Home"),
          backgroundColor: _theme.primaryColor,
        ),
        backLayer: Container(),
        frontLayer: Column(
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
