// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/controller&repository/characters_repository.dart';
import 'package:visual_novel_strider/widgets/characters_detail_widget/traits_list_widget.dart';

import '../model/kana_model/trait.dart';

class CharacterDetailBottomSheet extends StatelessWidget {
  CharacterDetailBottomSheet(
      {Key? key,
      required this.name,
      required this.id,
      required this.image,
      this.bannerImg})
      : super(key: key);

  final String id, name, image;
  String? bannerImg;

  final CharactersRepository _charactersRepository = Get.find();

  late List<Trait> traits = [];

  void getData() async {
    await _charactersRepository.getIndividualDetail(id);
    traits = _charactersRepository.individualResult.value.results.first.traits;
    // hairTrait =
    //     hairTrait.where((element) => element.groupName == "Hair").toList();
    // log(hairTrait[0].name);
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    getData();

    final height = MediaQuery.of(context).size.height - 100;

    return Container(
      height: height,
      child: Column(
        children: [
          Obx((() => Container(
              width: double.infinity,
              color: _charactersRepository.individualColor.value != null
                  ? Color(_charactersRepository.individualColor.value!)
                  : Colors.white,
              child: Icon(
                Icons.drag_handle,
                color: _charactersRepository.individualColor.value != null
                    ? Colors.white
                    : Colors.black,
              )))),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Obx(
                () => _charactersRepository
                        .individualResult.value.results.isNotEmpty
                    ? Container(
                        color: _theme.accentColor,
                        child: Column(
                          children: [
                            Stack(alignment: Alignment.bottomCenter, children: [
                              Container(
                                height: 120,
                                width: double.infinity,
                                color: _charactersRepository
                                            .individualColor.value !=
                                        null
                                    ? Color(_charactersRepository
                                        .individualColor.value!)
                                    : Colors.pink,
                                margin: EdgeInsets.only(bottom: 80),
                              ),
                              Positioned(
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: _charactersRepository
                                                    .individualColor.value !=
                                                null
                                            ? Color(_charactersRepository
                                                .individualColor.value!)
                                            : Colors.pink,
                                        shape: BoxShape.circle),
                                    child: ClipOval(
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(80),
                                        child: FadeInImage.memoryNetwork(
                                          placeholder: kTransparentImage,
                                          image: image,
                                          fit: BoxFit.none,
                                          alignment: Alignment.topCenter,
                                          imageScale: 1.2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                            Text(
                              name,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w900),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ReadMoreText(
                                _charactersRepository.individualResult.value
                                        .results.first.description ??
                                    "Hi, I'm using Wutsapp!",
                                textAlign: TextAlign.center,
                                colorClickableText: _theme.primaryColor,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(height: 16),
                            Column(
                              children: [
                                TraitsList(
                                  headerTitle: "Hair",
                                  icon: CupertinoIcons.person_alt_circle,
                                  traits: traits
                                      .where((element) =>
                                          element.groupName == "Hair")
                                      .toList(),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                TraitsList(
                                  headerTitle: "Eyes",
                                  icon: CupertinoIcons.eye_fill,
                                  traits: traits
                                      .where((element) =>
                                          element.groupName == "Eyes")
                                      .toList(),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                TraitsList(
                                  headerTitle: "Body",
                                  icon: CupertinoIcons.person_3_fill,
                                  traits: traits
                                      .where((element) =>
                                          element.groupName == "Body")
                                      .toList(),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                TraitsList(
                                  headerTitle: "Clothes",
                                  icon: CupertinoIcons.briefcase_fill,
                                  traits: traits
                                      .where((element) =>
                                          element.groupName == "Clothes")
                                      .toList(),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                TraitsList(
                                  headerTitle: "Personality",
                                  icon: CupertinoIcons.book_circle_fill,
                                  traits: traits
                                      .where((element) =>
                                          element.groupName == "Personality")
                                      .toList(),
                                ),
                                SizedBox(
                                  height: 16,
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    : Container(
                        color: _theme.accentColor,
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                          width: 60,
                          height: 60,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
