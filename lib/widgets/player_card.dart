import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (_) {
        return Text("test");
      },
    );
  }
}
