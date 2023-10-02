// ignore_for_file: unused_import

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/controller&repository/playground_controller.dart';
import 'package:visual_novel_strider/model/kana_model/branch_node_model.dart';
import 'package:visual_novel_strider/widgets/button_widgets/dotted_add_button.dart';
import 'package:visual_novel_strider/widgets/playground/branch_node_choice_selection_bottomsheet.dart';

class BranchChoiceNodeCard extends StatelessWidget {
  BranchChoiceNodeCard({Key? key, required this.index}) : super(key: key);

  final PlaygroundController playgroundController = Get.find();

  final int index;
  // final BranchNodeModel branchNode;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final branchNode =
            playgroundController.routes[index] as BranchNodeModel;
        // log("wow:" + branchNode.choices.length.toString());
        final selectedChoice =
            (playgroundController.routes[index] as BranchNodeModel)
                .choices
                .firstWhereOrNull((element) => element.isSelected == "true");
        if (!branchNode.hasSelected) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Branching Path",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 80,
                child: DottedAddButton(
                  onTap: () {
                    Get.bottomSheet(
                      BranchNodeChoiceSelectionBottomsheet(
                        branchNodeModel: branchNode,
                        onChoiceTap: (choice) {
                          playgroundController.selectChoice(choice, branchNode);
                          Get.back();
                        },
                      ),
                      ignoreSafeArea: false,
                    );
                  },
                  iconSize: 32,
                  title: "Please choice!",
                ),
              )
            ],
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Choice Selected",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: FractionallySizedBox(
                widthFactor: 0.95,
                child: ElevatedButton(
                    onPressed: () {
                      playgroundController.deselectChoice(
                          selectedChoice!, branchNode);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: Color(selectedChoice!.hexColor),
                        elevation: 4,
                        padding: const EdgeInsets.all(10)),
                    child: Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.all(8),
                            clipBehavior: Clip.antiAlias,
                            width: 64,
                            height: 64,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: FadeInImage.memoryNetwork(
                              image: selectedChoice.character.image!.url,
                              alignment: Alignment.topCenter,
                              fit: BoxFit.none,
                              imageScale: 2,
                              placeholder: kTransparentImage,
                            )),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '"${selectedChoice.choiceOrig}"',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              Text(
                                '"${selectedChoice.choiceTrans}"',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w200, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        );
      },
    );
  }
}
