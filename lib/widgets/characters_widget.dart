// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/controller&repository/characters_repository.dart';
import 'package:visual_novel_strider/model/kana_model/individual_result.dart';
import 'package:visual_novel_strider/widgets/characters_detail_bottom_sheets.dart';

class CharactersWidget extends StatelessWidget {
  const CharactersWidget(
      {Key? key, required this.vnId, required this.repository})
      : super(key: key);

  final CharactersRepository repository;

  final String vnId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(() {
      if (repository.result.value.results.isNotEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Container(
                      height: 22,
                      width: 4,
                      color: theme.primaryColor,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text(
                      "Characters",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () {
                      Get.showSnackbar(GetSnackBar(
                        backgroundColor: theme.primaryColor,
                        icon: Icon(
                          CupertinoIcons.check_mark_circled_solid,
                          color: theme.primaryColorLight,
                        ),
                        duration: const Duration(seconds: 2),
                        title: "a",
                        message: "Added to your Inventory",
                      ));
                    },
                    child: Icon(
                      Icons.info_outline_rounded,
                      size: 16,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 180,
              child: ListView.builder(
                itemCount: repository.result.value.results.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  IndividualResult e = repository.result.value.results[index];
                  return Row(
                    children: [
                      index == 0
                          ? const SizedBox(
                              width: 16,
                            )
                          : const SizedBox(),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              //TODO: on pressed (CharacterDetailWidget)
                              Get.bottomSheet(
                                  CharacterDetailBottomSheet(
                                    id: e.id,
                                    name: e.name,
                                    image: e.image != null ? e.image!.url : '',
                                  ),
                                  isScrollControlled: true,
                                  enableDrag: true);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    border:
                                        Border.all(color: Colors.grey[300]!)),
                                child: e.image != null
                                    ? SizedBox(
                                        height: 100,
                                        width: 140,
                                        child: ClipRRect(
                                          child: FadeInImage.memoryNetwork(
                                            image: e.image!.url,
                                            alignment: Alignment.topCenter,
                                            fit: BoxFit.fitWidth,
                                            placeholder: kTransparentImage,
                                          ),
                                        ),
                                      )
                                    : const Text("no image")),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            e.name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            e.vns
                                .firstWhere((element) => element.id == vnId)
                                .role!
                                .toUpperCase(),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w200, fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      }
      return const Text("nodata");
    });
  }
}
