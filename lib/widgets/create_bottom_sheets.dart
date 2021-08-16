// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/model/hive_model/hive_characters_model.dart';
import 'package:visual_novel_strider/notification_controller.dart';

class CreateBottomSheet extends StatelessWidget {
  CreateBottomSheet(
      {Key? key, required this.e, required this.vnID, required this.title})
      : super(key: key);

  final HiveCHaractersModel e;
  final NotificationController _controller = Get.find();
  final int vnID;
  final String title;
  final TextEditingController _textField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final DateTime _reminder = DateTime.now();
    final _theme = Theme.of(context);

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
                RotatedBox(
                  quarterTurns: -1,
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    color: _theme.primaryColor,
                    child: Text(
                      e.name!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: _theme.accentColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black, Colors.transparent])
                        .createShader(
                            Rect.fromLTRB(0, 190, bounds.width, bounds.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: Container(
                    height: 220,
                    width: 190,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: e.image!,
                      fit: BoxFit.none,
                      alignment: Alignment.topCenter,
                      imageScale: 1.3,
                    ),
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
                            Icons.remove_red_eye_rounded,
                            color: _theme.primaryColor,
                            size: 22,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Amber",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.face_retouching_natural_rounded,
                            color: _theme.primaryColor,
                            size: 22,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "White",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.timer_rounded,
                            color: _theme.primaryColor,
                            size: 22,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Amber",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w300),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                RotatedBox(
                  quarterTurns: -1,
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Text(
                          "Character Route Settings",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: _theme.primaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 5,
                          width: 280,
                          color: _theme.primaryColor,
                        )
                      ],
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
                        )
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
                            value: _controller.length.toString(),
                            isDense: true,
                            onChanged: (value) {
                              _controller.length.value = int.parse(value!);
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
                          if (_controller.hasReminder.value) {
                            return Text(_controller.reminder.toString());
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
                                  _controller.reminder = s;
                                  _controller.hasReminder.value = true;
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
                          _controller.note = _textField.text;
                          _controller.addToProgressRepository(e, vnID, title);
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
