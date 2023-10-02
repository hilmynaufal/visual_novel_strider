import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/event_creation_controller.dart';

import '../abstract_create_bottomsheet.dart';

class CreateBottomSheet extends AbstractCreateBottomSheet {
  CreateBottomSheet({
    super.key,
    required super.e,
    required super.vnID,
    required super.title,
    required super.controller,
    super.customCallbackForAddButton,
  });

  final _origTextController = TextEditingController();
  final _transTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return buildWidget(context, body: [
      TextField(
        controller: _origTextController,
        decoration: const InputDecoration(
          hintText: "Choice Text...",
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      TextField(
        controller: _transTextController,
        decoration: const InputDecoration(hintText: "Choice Text..."),
      ),
      ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: theme.primaryColorLight,
              backgroundColor: theme.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () async {
            addNode(controller);
            Get.back();
          },
          child: const Text("Add Node"))
    ]);
  }

  void addNode(EventCreationController controller) {
    String origText = _origTextController.text;
    String transText = _transTextController.text;
    controller.addNewChoice(origText, transText, e);
  }
}
