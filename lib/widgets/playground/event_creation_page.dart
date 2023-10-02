import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/event_creation_controller.dart';
import 'package:visual_novel_strider/controller&repository/playground_controller.dart';
import 'package:visual_novel_strider/widgets/button_widgets/dotted_add_button.dart';
import 'package:visual_novel_strider/widgets/character_card.dart';
import 'package:visual_novel_strider/widgets/create_bottom_sheets.dart';
import 'package:visual_novel_strider/widgets/route_detail_widget/abstract_route_settings.dart';
import 'package:visual_novel_strider/widgets/route_detail_widget/characters_drawer.dart';

class EventCreationPage extends AbstractSimpleMonochromePage {
  const EventCreationPage(
      {super.key, required super.subTitle, required super.title});

  @override
  Widget build(BuildContext context) {
    return buildWidget(context, body: [
      SizedBox(
        height: 200,
        width: double.infinity,
        child: GetBuilder<EventCreationController>(
            builder: (eventCreationController) {
          if (eventCreationController.eventNodePreview.value == null) {
            return DottedAddButton(
              title: "Costumize your Event Node!",
              onTap: () {
                showCharactersDrawer(
                    eventCreationController: eventCreationController);
              },
            );
          }
          return CharacterCard(
            nodeModel: eventCreationController.eventNodePreview.value,
            onCardPressed: () {
              showCharactersDrawer(
                  eventCreationController: eventCreationController);
            },
          );
        }),
      ),
      const SizedBox(
        height: 16,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide.none),
                  elevation: 0),
              child:
                  const Text("Cancel", style: TextStyle(color: Colors.black))),
          ElevatedButton(
              onPressed: () {
                // eventCreationController.handleNodeCreation();
                Get.find<EventCreationController>().handleNodeCreation();
              },
              style: ElevatedButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.black)),
                  elevation: 0),
              child: const Text(
                "Add",
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
    ]);
  }

  void showCharactersDrawer({required eventCreationController}) {
    final item = Get.find<PlaygroundController>().detailResult;
    Get.bottomSheet(CharactersDrawer(
      item: item,
      onCharacterSelected: (e) {
        Get.bottomSheet(
            CreateCardBottomSheet(
                e: e,
                onAddButtonPressed: (individualResult) {
                  eventCreationController.createEventNodePreview(e, item.id);
                },
                vnID: item.id,
                title: item.title,
                controller: eventCreationController),
            isScrollControlled: true);
      },
    ));
  }
}
