import 'package:flutter/material.dart';

class NSFWWidget extends StatelessWidget {
  const NSFWWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("NSFW",
        style: TextStyle(
            fontSize: 20,
            color: Colors.grey[300],
            fontWeight: FontWeight.bold));
  }
}
