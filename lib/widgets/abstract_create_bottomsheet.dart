import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/controller&repository/notification_controller.dart';
import 'package:visual_novel_strider/controller&repository/playground_controller.dart';
import 'package:visual_novel_strider/model/kana_model/node_model.dart';

import '../model/kana_model/individual_result.dart';
import '../model/kana_model/trait.dart';
import '../utils/constant/color_constant.dart';

abstract class AbstractCreateBottomSheet extends StatelessWidget {
  AbstractCreateBottomSheet(
      {Key? key,
      required this.e,
      required this.vnID,
      required this.title,
      this.customCallbackForAddButton,
      required this.controller})
      : super(key: key);

  final IndividualResult e;

  final dynamic controller;

  final Function? customCallbackForAddButton;
  final String vnID;
  final String title;
  final TextEditingController _textField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final DateTime _reminder = DateTime.now();
    final _theme = Theme.of(context);

    // _traitRepository.getTraits(e.traits);
    Trait? _hairColor = e.traits.firstWhereOrNull(
      (element) => ColorConstant.hairColor[element.id] != null,
    );

    Trait? _eyeColor = e.traits.firstWhereOrNull(
      (element) => ColorConstant.eyeColor[element.id] != null,
    );

    return Container(
      margin: EdgeInsets.only(top: 100),
      decoration: BoxDecoration(
        color: _theme.accentColor,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Obx(
                  () => RotatedBox(
                    quarterTurns: -1,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      color: Color(controller.hexColor.value),
                      child: Text(
                        e.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: _theme.accentColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: const [Colors.black, Colors.transparent])
                        .createShader(
                            Rect.fromLTRB(0, 190, bounds.width, bounds.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: Container(
                    height: 220,
                    width: 170,
                    child: e.image != null
                        ? FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: e.image!.url,
                            fit: BoxFit.none,
                            alignment: Alignment.topCenter,
                            imageScale: 1.3,
                          )
                        : SizedBox(),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.face_retouching_natural_rounded,
                              color: _theme.primaryColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              _hairColor?.name ?? "None",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.hexColor.value =
                                    ColorConstant.hairColor[_hairColor?.id] ??
                                        0xFF;
                              },
                              child: Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                    color: Color(ColorConstant
                                            .hairColor[_hairColor?.id] ??
                                        0xFF),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1, color: Colors.grey.shade300)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.remove_red_eye_rounded,
                              color: _theme.primaryColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              _eyeColor?.name ?? "None",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.hexColor.value =
                                    ColorConstant.eyeColor[_eyeColor?.id] ??
                                        0xFF;
                              },
                              child: Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                    color: Color(
                                        ColorConstant.eyeColor[_eyeColor?.id] ??
                                            0xFF),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1, color: Colors.grey.shade300)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ))
              ],
            ),
            Row(
              children: [
                RotatedBox(
                  quarterTurns: -1,
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Obx(
                      () => Column(
                        children: [
                          Text(
                            "Character Route Settings",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(controller.hexColor.value),
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            height: 5,
                            width: 280,
                            color: Color(controller.hexColor.value),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.color_lens,
                          color: _theme.primaryColor,
                          size: 18,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Color: ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Obx(
                          () => Container(
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                                color: Color(controller.hexColor.value),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 1, color: Colors.grey.shade300)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timelapse_outlined,
                          color: _theme.primaryColor,
                          size: 18,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Length: ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
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
                              DropdownMenuItem(
                                child: Text("1 Hour"),
                                value: "1",
                              ),
                              DropdownMenuItem(
                                child: Text("2 Hour"),
                                value: "2",
                              ),
                              DropdownMenuItem(
                                child: Text("5 Hour"),
                                value: "5",
                              ),
                              DropdownMenuItem(
                                child: Text("10 Hour"),
                                value: "10",
                              ),
                              DropdownMenuItem(
                                child: Text("20 Hour"),
                                value: "20",
                              ),
                              DropdownMenuItem(
                                child: Text("30 Hour"),
                                value: "30",
                              ),
                              DropdownMenuItem(
                                child: Text("40 Hour"),
                                value: "40",
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.color_lens,
                          color: _theme.primaryColor,
                          size: 18,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Reminder: ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        Obx(() {
                          if (controller.hasReminder.value) {
                            return Text(controller.reminder.toString());
                          }
                          return IconButton(
                              onPressed: () async {
                                final TimeOfDay? timeOfDay =
                                    await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (timeOfDay != null) {
                                  String s = timeOfDay.format(context);
                                  controller.reminder = s;
                                  controller.hasReminder.value = true;
                                }
                              },
                              icon: Icon(Icons.lock_clock));
                        })
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Column(
                      children: [
                        TextField(
                          controller: _textField,
                          decoration: InputDecoration(
                            labelText: "Note",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            prefixIcon: Icon(
                              Icons.note_alt_rounded,
                              color: _theme.primaryColor,
                              size: 22,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: _theme.primaryColor,
                            onPrimary: _theme.accentColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () async {
                          controller.note = _textField.text;
                          if (controller is NotificationController) {
                            controller.addToProgressRepository(e, vnID, title);
                          } else if (controller is PlaygroundController) {
                            controller.createNewNodePreview(e.id, e, vnID);
                          }
                          Get.back();
                        },
                        child: Text("Add Character Route"))
                  ],
                )),
                SizedBox(
                  width: 16,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
