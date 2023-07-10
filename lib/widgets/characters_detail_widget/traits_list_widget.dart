import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../model/kana_model/trait.dart';

class TraitsList extends StatelessWidget {
  const TraitsList({Key? key, required this.traits, required this.headerTitle})
      : super(key: key);

  final String headerTitle;
  final List<Trait> traits;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 16,
            ),
            Icon(
              CupertinoIcons.person_alt_circle,
              size: 24,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              headerTitle,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        traits.isNotEmpty
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 4,
                  runSpacing: 8,
                  children: traits
                      .map((e) {
                        return Container(
                          height: 18,
                          // margin: EdgeInsets.only(right: 8),
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: _theme.primaryColor, width: 0.5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Text(
                                    e.name,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: _theme.primaryColor),
                                  ),
                                ],
                              )),
                        );
                      })
                      .toList()
                      .cast<Widget>(),
                ),
              )
            : CircularProgressIndicator()
      ],
    );
  }
}
