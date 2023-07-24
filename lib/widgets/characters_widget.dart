// ignore_for_file: deprecated_member_use

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/controller&repository/characters_repository.dart';
import 'package:visual_novel_strider/model/kana_model/characters_result.dart';
import 'package:visual_novel_strider/model/kana_model/individual_result.dart';
import 'package:visual_novel_strider/widgets/characters_detail_bottom_sheets.dart';

class CharactersWidget extends StatelessWidget {
  CharactersWidget({Key? key, required this.vnId}) : super(key: key);

  final CharactersRepository _repository = Get.find();

  final String vnId;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Obx(() {
      if (_repository.result.value.results.isNotEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: const Text("Characters",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () {
                      Get.showSnackbar(GetSnackBar(
                        backgroundColor: _theme.primaryColor,
                        icon: Icon(
                          CupertinoIcons.check_mark_circled_solid,
                          color: _theme.accentColor,
                        ),
                        duration: const Duration(seconds: 2),
                        title: "a",
                        message: "Added to your Inventory",
                      ));
                    },
                    child: Icon(
                      Icons.info_outline_rounded,
                      size: 16,
                      color: _theme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: _repository.result.value.results.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  IndividualResult _e = _repository.result.value.results[index];
                  return Row(
                    children: [
                      index == 0
                          ? SizedBox(
                              width: 16,
                            )
                          : SizedBox(),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              //TODO: on pressed (CharacterDetailWidget)
                              Get.bottomSheet(
                                  CharacterDetailBottomSheet(
                                    id: _e.id,
                                    name: _e.name,
                                    image:
                                        _e.image != null ? _e.image!.url : '',
                                  ),
                                  isScrollControlled: true,
                                  enableDrag: true);
                            },
                            child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    border:
                                        Border.all(color: Colors.grey[300]!)),
                                child: _e.image != null
                                    ? SizedBox(
                                        height: 100,
                                        width: 140,
                                        child: ClipRRect(
                                          child: FadeInImage.memoryNetwork(
                                            image: _e.image!.url,
                                            alignment: Alignment.topCenter,
                                            fit: BoxFit.fitWidth,
                                            placeholder: kTransparentImage,
                                          ),
                                        ),
                                      )
                                    : const Text("no image")),
                          ),
                          SizedBox(height: 8),
                          Text(
                            _e.name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            _e.vns
                                .firstWhere((element) => element.id == vnId)
                                .role!
                                .toUpperCase(),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w200, fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 16,
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 80,
            )
          ],
        );
      }
      return const Text("nodata");
    });
  }
}
