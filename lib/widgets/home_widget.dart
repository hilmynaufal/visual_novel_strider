// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    return Obx(() {
      if (_repository.server.isReady.value) {
        return Obx(() {
          if (_repository.result.value.num != 0) {
            return Obx(() {
              _hiveRepository.getLatestSchedule();
              if (_repository.isReady.value) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Obx(() {
                        if (_hiveRepository.result[0].id == 0) {
                          _hiveRepository.getLatestSchedule();
                          return Text("Asw");
                        } else {
                          return SizedBox(
                            height: 220,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _hiveRepository.result.length,
                              itemBuilder: (context, index) => SizedBox(
                                width: 360,
                                child: CharacterCard(
                                    index: index,
                                    item: _hiveRepository.data![index]),
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
                        height: 1,
                      ),
                      PopularWidget(),
                      SizedBox(
                        height: 1,
                      ),
                      NakigeWidget()
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            });
          } else {
            _repository.getNewReleased();
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }
}
