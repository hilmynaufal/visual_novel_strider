import 'package:flutter/material.dart';
import 'package:visual_novel_strider/model/hive_model/hive_characters_model.dart';

class CreateBottomSheet extends StatelessWidget {
  const CreateBottomSheet({Key? key, required this.e}) : super(key: key);

  final HiveCHaractersModel e;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(color: _theme.accentColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            e.name!,
            style: TextStyle(color: _theme.primaryColor, fontSize: 22),
          ),
        ],
      ),
    );
  }
}
