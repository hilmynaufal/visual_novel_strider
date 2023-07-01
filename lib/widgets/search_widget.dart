import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:visual_novel_strider/controller&repository/search_repository.dart';

import 'item_widget.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Column(
      children: [
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
            const Text(
              "Search Result",
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
        GetBuilder<SearchRepository>(builder: (_controller) {
          if (!_controller.isReady.value) {
            return const Text("No Data");
          }
          return const ItemWidget();
        }),
      ],
    );
  }
}
