import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/playground_controller.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';
import 'package:visual_novel_strider/widgets/button_widgets/transparent_rounded_button.dart';
import 'package:visual_novel_strider/widgets/page_widgets/new_route_settings_page.dart';
import 'package:visual_novel_strider/widgets/route_detail_widget/abstract_route_settings.dart';

class NewRouteBranchTypeSelectionPage extends AbstractRouteSetings {
  const NewRouteBranchTypeSelectionPage(
      {required this.playgroundController, required this.item, Key? key})
      : super(
          key: key,
          title: "Routes Settings",
          subTitle:
              "You're about to create Routes for this Visual Novel. Please select route brancing type:",
        );
  final PlaygroundController playgroundController;
  final DetailResult item;

  @override
  Widget build(BuildContext context) {
    return buildWidget(context, body: <Widget>[
      TransparentRoundedButton(
          onTap: () {
            playgroundController.routeBranchType.value = "kinetic";
            Get.to(() => NewRouteSettingsPage(
                  item: item,
                  playgroundController: playgroundController,
                ));
          },
          headerTitle: "Kinetic Novel",
          description:
              "A kinetic novel is a VN that does not present the player with any choices at all; they simply read through a single unbranching story.",
          icon: CupertinoIcons.down_arrow),
      SizedBox(
        height: 16,
      ),
      TransparentRoundedButton(
          headerTitle: "Choice-based",
          description:
              "A kinetic novel is a VN that does not present the player with any choices at all; they simply read through a single unbranching story.",
          icon: CupertinoIcons.arrow_branch),
      SizedBox(
        height: 16,
      ),
      TransparentRoundedButton(
          headerTitle: "Point-based",
          description:
              "A kinetic novel is a VN that does not present the player with any choices at all; they simply read through a single unbranching story.",
          icon: CupertinoIcons.add_circled_solid),
    ]);
  }
}
