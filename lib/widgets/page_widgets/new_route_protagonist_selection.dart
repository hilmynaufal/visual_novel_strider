import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/playground_controller.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';
import 'package:visual_novel_strider/widgets/button_widgets/rectangle_box_selection_button.dart';
import 'package:visual_novel_strider/widgets/character_card.dart';
import 'package:visual_novel_strider/widgets/create_bottom_sheets.dart';
import 'package:visual_novel_strider/widgets/playground/playground_creation_intermediate.dart';
import 'package:visual_novel_strider/widgets/route_detail_widget/abstract_route_settings.dart';
import 'package:visual_novel_strider/widgets/route_detail_widget/characters_drawer.dart';

import '../../model/kana_model/individual_result.dart';

class NewRouteProtagonistSelectionPage extends AbstractSimpleMonochromePage {
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
          Get.to(() => const PlaygroundCreationIntermediate());
        },
      ),
      const SizedBox(
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
              onCharacterSelected: (IndividualResult e) {
                Get.bottomSheet(CreateCardBottomSheet(
                    e: e,
                    onAddButtonPressed: (individualResult) {
                      playgroundController.createNewNodePreview(e, item.id);
                    },
                    vnID: item.id,
                    title: title,
                    controller: playgroundController));
              },
            ),
          );
        },
      ),
      const SizedBox(
        height: 32,
      ),
      Obx(() => playgroundController.currentNode.value == null
          ? const SizedBox()
          : GestureDetector(
              onTap: () {
                Get.to(() => const PlaygroundCreationIntermediate());
              },
              child: SizedBox(
                height: 230,
                child: CharacterCard(
                  nodeModel: playgroundController.currentNode.value!,
                  onCardPressed: () {},
                ),
              ),
            ))
    ]);
  }
}
