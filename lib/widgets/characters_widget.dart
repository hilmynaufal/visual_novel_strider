// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/controller&repository/characters_repository.dart';
import 'package:visual_novel_strider/model/kana_model/characters_result.dart';

class CharactersWidget extends StatelessWidget {
  CharactersWidget({Key? key}) : super(key: key);

  final CharactersRepository _repository = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_repository.result.value.results.isNotEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: const Text("Characters",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  )),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: Wrap(
                spacing: 10,
                runSpacing: 20,
                alignment: WrapAlignment.spaceEvenly,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.horizontal,
                children: _repository.result.value.results
                    .map((e) {
                      CharactersResult _e = e;
                      return Column(
                        children: [
                          ElevatedButton(
                              clipBehavior: Clip.antiAlias,
                              onPressed: () {
                                //TODO: on pressed (CharacterDetailWidget)
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  side: BorderSide(
                                      width: 1,
                                      color: Theme.of(context).primaryColor),
                                  elevation: 4,
                                  primary: Theme.of(context).accentColor),
                              child: _e.image != null
                                  ? FadeInImage.memoryNetwork(
                                      imageScale: 2,
                                      placeholder: kTransparentImage,
                                      image: _e.image!.url,
                                      alignment: Alignment.topCenter,
                                      fit: BoxFit.cover,
                                    )
                                  : const Text("no image")),
                          Text(
                            _e.name!,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      );
                    })
                    .toList()
                    .cast<Widget>(),
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