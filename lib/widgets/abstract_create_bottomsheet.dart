import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

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
  final TextEditingController textField = TextEditingController();

  Widget buildWidget(BuildContext context, {required List<Widget> body}) {
    // final DateTime reminder = DateTime.now();
    final theme = Theme.of(context);

    // _traitRepository.getTraits(e.traits);
    Trait? hairColor = e.traits.firstWhereOrNull(
      (element) => ColorConstant.hairColor[element.id] != null,
    );

    Trait? eyeColor = e.traits.firstWhereOrNull(
      (element) => ColorConstant.eyeColor[element.id] != null,
    );

    return Container(
      margin: const EdgeInsets.only(top: 100),
      decoration: BoxDecoration(
        color: theme.primaryColorLight,
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
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      color: Color(controller.hexColor.value),
                      child: Text(
                        e.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: theme.primaryColorLight,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black, Colors.transparent])
                        .createShader(
                            Rect.fromLTRB(0, 190, bounds.width, bounds.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: SizedBox(
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
                        : const SizedBox(),
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
                              color: theme.primaryColor,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              hairColor?.name ?? "None",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.hexColor.value =
                                    ColorConstant.hairColor[hairColor?.id] ??
                                        0xFF;
                              },
                              child: Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                    color: Color(ColorConstant
                                            .hairColor[hairColor?.id] ??
                                        0xFF),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1, color: Colors.grey.shade300)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.remove_red_eye_rounded,
                              color: theme.primaryColor,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              eyeColor?.name ?? "None",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.hexColor.value =
                                    ColorConstant.eyeColor[eyeColor?.id] ??
                                        0xFF;
                              },
                              child: Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                    color: Color(
                                        ColorConstant.eyeColor[eyeColor?.id] ??
                                            0xFF),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1, color: Colors.grey.shade300)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
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
                    margin: const EdgeInsets.only(left: 20, right: 20),
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
                const SizedBox(
                  width: 16,
                ),
                Expanded(child: Column(children: [...body])),
                const SizedBox(
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
