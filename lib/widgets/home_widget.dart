// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/hive_repository.dart';
import 'package:visual_novel_strider/controller&repository/home_repository.dart';
import 'package:visual_novel_strider/widgets/key_widget.dart';
import 'package:visual_novel_strider/widgets/latest_widget.dart';
import 'package:visual_novel_strider/widgets/nakige_widget.dart';
import 'package:visual_novel_strider/widgets/popular_widget.dart';
import 'package:visual_novel_strider/widgets/vn_highlight.dart';
import 'package:visual_novel_strider/widgets/yuzusoft_widget.dart';

class HomeWidget extends StatelessWidget {
  HomeWidget({Key? key}) : super(key: key);

  final HomeRepository _repository = Get.put(HomeRepository());

  final HiveRepository _hiveRepository = Get.find();

  @override
  Widget build(BuildContext context) {
    _hiveRepository.getLatestSchedule();

    final theme = Theme.of(context);
    return Obx(
      () {
        if (_repository.isReady.value) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Container(
                      height: 22,
                      width: 4,
                      color: theme.primaryColor,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Latest Schedule",
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
                Obx(() {
                  if (_hiveRepository.result.isEmpty) {
                    return Text("Your latest schedule will show up here.");
                  } else {
                    return Text("is playing");
                    // return SizedBox(
                    //   height: 220,
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: _hiveRepository.result.length,
                    //     itemBuilder: (context, index) => SizedBox(
                    //       width: 340,
                    //       child: CharacterCard(
                    //           index: index, item: _hiveRepository.data![index]),
                    //     ),
                    //   ),
                    // );
                  }
                }),
                SizedBox(
                  height: 16,
                ),
                VNHighlightWidget(
                  id: "",
                  imageAssetUrl: 'assets/sorcery_jokers.jpg',
                  developer: "3rdEye",
                  title: "Sorcery Jokers",
                ),
                SizedBox(
                  height: 32,
                ),
                LatestWidget(),
                SizedBox(
                  height: 16,
                ),
                VNHighlightWidget(
                  id: "",
                  developer: "RASK",
                  title: "Re: LieF ~Shin'ainaru Anata e~",
                  imageAssetUrl: 'assets/relief.jpg',
                ),
                SizedBox(
                  height: 32,
                ),
                PopularWidget(),
                SizedBox(
                  height: 16,
                ),
                VNHighlightWidget(
                  id: "",
                  developer: "Yuzusoft",
                  title: "Café Stella to Shinigami no Chou",
                  imageAssetUrl: 'assets/cafe_stella.jpg',
                ),
                SizedBox(
                  height: 32,
                ),
                NakigeWidget(),
                SizedBox(
                  height: 16,
                ),
                YuzusoftWidget(),
                SizedBox(
                  height: 16,
                ),
                VNHighlightWidget(
                  id: "",
                  developer: "Key",
                  title: "Summer Pockets",
                  imageAssetUrl: 'assets/summer_pockets.jpg',
                ),
                SizedBox(
                  height: 32,
                ),
                KeyWidget(),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 120,
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
    // _hiveRepository.getLatestSchedule();
  }
}
