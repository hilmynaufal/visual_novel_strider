import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';
import 'package:visual_novel_strider/model/kana_model/individual_result.dart';

class CharactersDrawer extends StatelessWidget {
  const CharactersDrawer(
      {Key? key,
      required this.item,
      this.customCallbackForAddButton,
      required this.onCharacterSelected})
      : super(key: key);

  final DetailResult item;
  // final GetxController controller;
  final void Function(String e)? customCallbackForAddButton;
  final void Function(IndividualResult e) onCharacterSelected;

  // final NotificationController _notificationController = Get.find();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 127, 198, 255),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(children: [
                  Icon(
                    Icons.menu,
                    color: theme.primaryColorLight,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Characters Drawer",
                    style: TextStyle(
                        color: theme.primaryColorLight,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ]),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 16,
          color: Colors.yellow.shade500,
          child: Center(
            child: Text(
              "Some spoiler may be not filtered!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.yellow.shade900,
                  fontSize: 11,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            color: theme.primaryColorLight,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    children: item.characters!
                        .asMap()
                        .entries
                        .map((e) {
                          return ElevatedButton(
                            onPressed: () {
                              Get.back();
                              onCharacterSelected(e.value);
                            },
                            clipBehavior: Clip.antiAlias,
                            style: ElevatedButton.styleFrom(
                                elevation: 4,
                                backgroundColor: theme.primaryColorLight,
                                side: BorderSide(
                                    width: 0, color: theme.primaryColorLight),
                                padding: const EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14))),
                            child: e.value.image != null
                                ? SizedBox(
                                    height: 100,
                                    width: 70,
                                    child: ClipRRect(
                                        child: FadeInImage.memoryNetwork(
                                            fit: BoxFit.cover,
                                            imageScale: 3,
                                            alignment: Alignment.topCenter,
                                            placeholder: kTransparentImage,
                                            image: e.value.image!.url)))
                                : const SizedBox(
                                    height: 100,
                                    width: 70,
                                    child: Text("No Image"),
                                  ),
                          );
                        })
                        .toList()
                        .cast<Widget>()),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
