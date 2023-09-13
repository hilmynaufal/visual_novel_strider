import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/playground_controller.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';
import 'package:visual_novel_strider/widgets/button_widgets/rectangle_box_selection_button.dart';
import 'package:visual_novel_strider/widgets/character_card.dart';
import 'package:visual_novel_strider/widgets/playground/playground_creation_intermediate.dart';
import 'package:visual_novel_strider/widgets/route_detail_widget/abstract_route_settings.dart';
import 'package:visual_novel_strider/widgets/route_detail_widget/characters_drawer.dart';
import 'package:visual_novel_strider/widgets/playground/route_playground_page.dart';

class NewRouteProtagonistSelectionPage extends AbstractRouteSetings {
  const NewRouteProtagonistSelectionPage(
      {Key? key, required this.item, required this.playgroundController})
      : super(
          key: key,
          title: "Start your journey",
          subTitle:
              "To start your journey, please select your protagonist from Characters drawer:",
        );
  final PlaygroundController playgroundController;
  final DetailResult item;

  @override
  Widget build(BuildContext context) {
    return buildWidget(context, body: <Widget>[
      RectangleBoxSelectionButton(
        imgUrl: item.characters!.first.image!.url,
        headerTitle: item.characters!.first.name,
        description: "as Protagonist 1",
        onPressed: () {
          Get.to(() => PlaygroundCreationIntermediate());
        },
      ),
      SizedBox(
        height: 16,
      ),
      RectangleBoxSelectionButton(
        imgUrl: item.characters![2].image!.url,
        headerTitle: item.characters![2].name,
        description: "as Protagonist 2",
        onPressed: () {
          Get.bottomSheet(
            CharactersDrawer(
              item: item,
              controller: 'playground',
            ),
          );
        },
      ),
      SizedBox(
        height: 32,
      ),
      Obx(() => playgroundController.currentNode.value == null
          ? SizedBox()
          : GestureDetector(
              onTap: () {
                Get.to(() => PlaygroundCreationIntermediate());
              },
              child: Container(
                height: 230,
                child: CharacterCard(
                    nodeModel: playgroundController.currentNode.value!),
              ),
            ))
    ]);
  }
}
