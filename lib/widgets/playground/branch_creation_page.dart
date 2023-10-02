import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/event_creation_controller.dart';
import 'package:visual_novel_strider/controller&repository/playground_controller.dart';
import 'package:visual_novel_strider/widgets/button_widgets/dotted_add_button.dart';
import 'package:visual_novel_strider/widgets/playground/branch_node_choice_selection_card.dart';
import 'package:visual_novel_strider/widgets/playground/create_initial_protagonist_bottomsheet.dart';
import 'package:visual_novel_strider/widgets/route_detail_widget/abstract_route_settings.dart';
import 'package:visual_novel_strider/widgets/route_detail_widget/characters_drawer.dart';

class BranchCreationPage extends AbstractSimpleMonochromePage {
  BranchCreationPage(
      {super.key, required super.title, required super.subTitle});

  final EventCreationController eventCreationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return buildWidget(context, body: [
      GetBuilder<EventCreationController>(builder: (controller) {
        return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.newChoices.length + 1,
            itemBuilder: (context, index) {
              if (index == controller.newChoices.length) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  height: 80,
                  child: DottedAddButton(
                    onTap: () {
                      final item =
                          Get.find<PlaygroundController>().detailResult;
                      Get.bottomSheet(
                        CharactersDrawer(
                          item: item,
                          customCallbackForAddButton: (e) {
                            controller.well();
                          },
                          onCharacterSelected: (e) {
                            Get.bottomSheet(
                                CreateBottomSheet(
                                    e: e,
                                    vnID: item.id,
                                    title: title,
                                    controller: controller),
                                isScrollControlled: true);
                          },
                        ),
                        enableDrag: true,
                      );
                    },
                    iconSize: 32,
                  ),
                );
              }
              return BranchNodeChoiceSelectionCard(
                  onTap: null, choice: controller.newChoices[index]);
            });
      }),
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
                eventCreationController.handleNodeCreation();
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
}
