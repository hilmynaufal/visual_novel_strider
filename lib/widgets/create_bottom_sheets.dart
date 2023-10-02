import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/notification_controller.dart';
import 'package:visual_novel_strider/model/kana_model/individual_result.dart';
import 'package:visual_novel_strider/widgets/abstract_create_bottomsheet.dart';

import '../controller&repository/playground_controller.dart';

class CreateCardBottomSheet extends AbstractCreateBottomSheet {
  CreateCardBottomSheet(
      {super.key,
      required super.e,
      required this.onAddButtonPressed,
      required super.vnID,
      required super.title,
      required super.controller});

  final void Function(IndividualResult individualResult) onAddButtonPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return buildWidget(context, body: [
      Row(
        children: [
          Icon(
            Icons.color_lens,
            color: theme.primaryColor,
            size: 18,
          ),
          const SizedBox(
            width: 8,
          ),
          const Text(
            "Color: ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            width: 8,
          ),
          Obx(
            () => Container(
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                  color: Color(controller.hexColor.value),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: Colors.grey.shade300)),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 16,
      ),
      Row(
        children: [
          Icon(
            Icons.timelapse_outlined,
            color: theme.primaryColor,
            size: 18,
          ),
          const SizedBox(
            width: 8,
          ),
          const Text(
            "Length: ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
          ),
          DropdownButtonHideUnderline(
              child: Obx(
            () => DropdownButton<String>(
              value: controller.length.toString(),
              isDense: true,
              onChanged: (value) {
                controller.length.value = int.parse(value!);
              },
              // ignore: prefer_const_literals_to_create_immutables
              items: [
                const DropdownMenuItem(
                  value: "1",
                  child: Text("1 Hour"),
                ),
                const DropdownMenuItem(
                  value: "2",
                  child: Text("2 Hour"),
                ),
                const DropdownMenuItem(
                  value: "5",
                  child: Text("5 Hour"),
                ),
                const DropdownMenuItem(
                  value: "10",
                  child: Text("10 Hour"),
                ),
                const DropdownMenuItem(
                  value: "20",
                  child: Text("20 Hour"),
                ),
                const DropdownMenuItem(
                  value: "30",
                  child: Text("30 Hour"),
                ),
                const DropdownMenuItem(
                  value: "40",
                  child: Text("40 Hour"),
                )
              ],
            ),
          ))
        ],
      ),
      const SizedBox(
        height: 16,
      ),
      Row(
        children: [
          Icon(
            Icons.color_lens,
            color: theme.primaryColor,
            size: 18,
          ),
          const SizedBox(
            width: 8,
          ),
          const Text(
            "Reminder: ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
          ),
          Obx(() {
            if (controller.hasReminder.value) {
              return Text(controller.reminder.toString());
            }
            return IconButton(
                onPressed: () async {
                  final TimeOfDay? timeOfDay = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (timeOfDay != null) {
                    String s = timeOfDay.format(context);
                    controller.reminder = s;
                    controller.hasReminder.value = true;
                  }
                },
                icon: const Icon(Icons.lock_clock));
          })
        ],
      ),
      const SizedBox(
        height: 16,
      ),
      Column(
        children: [
          TextField(
            controller: textField,
            decoration: InputDecoration(
              labelText: "Note",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              prefixIcon: Icon(
                Icons.note_alt_rounded,
                color: theme.primaryColor,
                size: 22,
              ),
            ),
          )
        ],
      ),
      const SizedBox(
        height: 8,
      ),
      ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: theme.primaryColorLight,
              backgroundColor: theme.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () async {
            controller.note = textField.text;
            onAddButtonPressed(e);
            if (controller is NotificationController) {
              (controller as NotificationController)
                  .addToProgressRepository(e, vnID, title);
            } else if (controller is PlaygroundController) {
              (controller as PlaygroundController)
                  .createNewNodePreview(e, vnID);
            }
            Get.back();
          },
          child: const Text("Add Character Route"))
    ]);
  }
}
