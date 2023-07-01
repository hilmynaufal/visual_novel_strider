import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NSFWWidget extends StatelessWidget {
  const NSFWWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("NSFW",
        style: TextStyle(
            fontSize: 22,
            color: Colors.grey[500],
            fontWeight: FontWeight.bold));
  }
}
