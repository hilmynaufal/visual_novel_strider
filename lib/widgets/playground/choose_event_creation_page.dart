import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/event_creation_controller.dart';
import 'package:visual_novel_strider/widgets/button_widgets/transparent_rounded_button.dart';
import 'package:visual_novel_strider/widgets/playground/branch_creation_page.dart';
import 'package:visual_novel_strider/widgets/playground/event_creation_page.dart';
import 'package:visual_novel_strider/widgets/route_detail_widget/abstract_route_settings.dart';

class ChooseEventCreationPage extends AbstractSimpleMonochromePage {
  ChooseEventCreationPage(
      {super.key, required super.title, required super.subTitle});

  final EventCreationController eventCreationController =
      Get.put(EventCreationController());

  @override
  Widget build(BuildContext context) {
    return buildWidget(context, body: [
      TransparentRoundedButton(
        headerTitle: "Event",
        description:
            "Event node is just a basic common type event that has it's own playtime, target, note etc.",
        icon: CupertinoIcons.creditcard_fill,
        onTap: () {
          eventCreationController.newNodeType.value = "event";
          Get.to(() => const EventCreationPage(
              subTitle: "Add event node.", title: "Event Creation"));
        },
      ),
      const SizedBox(
        height: 8,
      ),
      TransparentRoundedButton(
        headerTitle: "Branch",
        description:
            "A branch node let you specify a choice that will make an impact to the storyline.",
        icon: CupertinoIcons.arrow_branch,
        onTap: () {
          eventCreationController.newNodeType.value = "branch";
          Get.to(() => BranchCreationPage(
              title: "Branch Creation", subTitle: "Please Make a choice!"));
        },
      ),
      const SizedBox(
        height: 8,
      ),
      const TransparentRoundedButton(
          headerTitle: "Note",
          description:
              "A node that's don't have any impact of the game. Use this if you want to make a simple note.",
          icon: CupertinoIcons.paperclip),
    ]);
  }
}
