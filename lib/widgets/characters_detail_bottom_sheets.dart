// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/controller&repository/characters_repository.dart';

class CharacterDetailBottomSheet extends StatelessWidget {
  CharacterDetailBottomSheet(
      {Key? key, required this.name, required this.id, required this.image})
      : super(key: key);

  final String id, name, image;

  final CharactersRepository _charactersRepository = Get.find();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    _charactersRepository.getIndividualDetail(id);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Obx(
        () => _charactersRepository.individualResult.value.results.isNotEmpty
            ? Container(
                color: _theme.accentColor,
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Stack(alignment: Alignment.bottomCenter, children: [
                      ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: const [
                                Colors.black,
                                Colors.transparent
                              ]).createShader(Rect.fromLTRB(
                              0, 200, bounds.width, bounds.height));
                        },
                        blendMode: BlendMode.dstIn,
                        child: SizedBox(
                          height: 280,
                          width: 220,
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: image,
                            fit: BoxFit.none,
                            alignment: Alignment.topCenter,
                            imageScale: 1.0,
                          ),
                        ),
                      ),
                      Positioned(
                          child: Text(
                        name,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 36,
                            fontWeight: FontWeight.w900),
                      ))
                    ]),
                    SizedBox(height: 16),
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
    );
  }
}
