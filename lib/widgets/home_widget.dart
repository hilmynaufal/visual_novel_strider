// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/hive_repository.dart';
import 'package:visual_novel_strider/controller&repository/home_repository.dart';
import 'package:visual_novel_strider/widgets/character_card.dart';
import 'package:visual_novel_strider/widgets/latest_widget.dart';
import 'package:visual_novel_strider/widgets/nakige_widget.dart';
import 'package:visual_novel_strider/widgets/popular_widget.dart';

class HomeWidget extends StatelessWidget {
  HomeWidget({Key? key}) : super(key: key);

  final HomeRepository _repository = Get.put(HomeRepository());

  final HiveRepository _hiveRepository = Get.find();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
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
                  if (_hiveRepository.isReady.isTrue &&
                      _hiveRepository.result[0].id == '0') {
                    _hiveRepository.getLatestSchedule();
                    return Text("Your latest schedule will show up here.");
                  } else {
                    return SizedBox(
                      height: 220,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _hiveRepository.result.length,
                        itemBuilder: (context, index) => SizedBox(
                          width: 360,
                          child: CharacterCard(
                              index: index, item: _hiveRepository.data![index]),
                        ),
                      ),
                    );
                  }
                }),
                SizedBox(
                  height: 16,
                ),
                LatestWidget(),
                SizedBox(
                  height: 16,
                ),
                PopularWidget(),
                SizedBox(
                  height: 16,
                ),
                NakigeWidget(),
                SizedBox(
                  height: 32,
                )
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
