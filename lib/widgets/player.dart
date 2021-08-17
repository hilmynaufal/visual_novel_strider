import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:visual_novel_strider/controller&repository/player_controller.dart';

class Player extends StatelessWidget {
  Player({Key? key, required this.index}) : super(key: key);

  final PlayerController _playerController = Get.find();

  int index;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_playerController.stopList.value != 0) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              StopWatchTimer.getDisplayTime(_playerController.stopList.value,
                  hours: true, milliSecond: false),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 4,
            ),
          ],
        );
      }
      return Text("data");
    });
  }
}
