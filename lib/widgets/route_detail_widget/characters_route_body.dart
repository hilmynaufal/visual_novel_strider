import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';

import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/notification_controller.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';

import '../character_card.dart';

class CharactersRouteBody extends StatelessWidget {
  CharactersRouteBody({Key? key, required this.item}) : super(key: key);

  final DetailResult item;

  final NotificationController _notificationController = Get.find();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: Obx(() {
            if (_notificationController.hiveRepository.result[0].id == '0') {
              return const Center(
                  child: Text("Open Character's Drawer to Add Route Card"));
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: _notificationController.hiveRepository.result.length,
              itemBuilder: (context, index) => SizedBox(
                  height: 215, child: CharacterCard(index: index, item: item)),
            );
          }),
        ),
      ],
    );
  }
}
