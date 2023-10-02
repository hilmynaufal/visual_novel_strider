import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/playground_controller.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';
import 'package:visual_novel_strider/widgets/button_widgets/dotted_add_button.dart';
import 'package:visual_novel_strider/widgets/new_route_branch_type_selection.dart';

class RoutesMakerBody extends StatelessWidget {
  const RoutesMakerBody({Key? key, required this.item}) : super(key: key);

  final DetailResult item;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: DottedAddButton(
          title: "Add new routes for this visual novel.",
          onTap: () {
            Get.to(() => NewRouteBranchTypeSelectionPage(
                  item: item,
                  playgroundController: Get.find<PlaygroundController>(),
                ));
            // Get.bottomSheet(CharactersDrawer(
            //   item: item,
            //   controller: '',
            // ));
          },
          iconSize: 64,
        ),
      ),
    );
  }
}
