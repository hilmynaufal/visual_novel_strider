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
                          ElevatedButton(
                              clipBehavior: Clip.antiAlias,
                              onPressed: () {
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
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  // side: BorderSide(
                                  //     width: 1,
                                  //     color: Theme.of(context).primaryColor),
                                  elevation: 4,
                                  primary: Theme.of(context).accentColor),
                              child: _e.image != null
                                  ? SizedBox(
                                      height: 100,
                                      width: 70,
                                      child: ClipRRect(
                                        child: FadeInImage.memoryNetwork(
                                          image: _e.image!.url,
                                          alignment: Alignment.topCenter,
                                          fit: BoxFit.cover,
                                          placeholder: kTransparentImage,
                                        ),
                                      ),
                                    )
                                  : const Text("no image")),
                          SizedBox(height: 8),
                          SizedBox(
                            width: 70,
                            child: Text(
                              _e.name,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
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
