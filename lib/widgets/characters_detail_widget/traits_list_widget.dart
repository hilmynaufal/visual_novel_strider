import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../model/kana_model/trait.dart';

class TraitsList extends StatelessWidget {
  const TraitsList(
      {Key? key,
      required this.traits,
      required this.headerTitle,
      required this.icon})
      : super(key: key);

  final String headerTitle;
  final List<Trait> traits;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 16,
            ),
            Icon(
              icon,
              size: 18,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              headerTitle + ' : ',
              style: TextStyle(fontSize: 14),
            ),
            traits.isNotEmpty
                ? Expanded(
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      direction: Axis.horizontal,
                      runSpacing: 8,
                      children: traits
                          .map((e) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  e.name,
                                  style: TextStyle(color: _theme.primaryColor),
                                ),
                                const Text(
                                  ", ",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            );
                          })
                          .toList()
                          .cast<Widget>(),
                    ),
                  )
                : Container(child: CircularProgressIndicator())
          ],
        ),
      ],
    );
  }
}
