import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/characters_repository.dart';

class CharactersWidget extends StatelessWidget {
  CharactersWidget({Key? key}) : super(key: key);

  final CharactersRepository _repository = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_repository.result.value.num != 0) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Characters",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )),
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
                children: _repository.result.value.charaItems!
                    .map((e) {
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
                              child: e.image != null
                                  ? Image.network(
                                      e.image!,
                                      alignment: Alignment.topCenter,
                                      fit: BoxFit.cover,
                                      scale: 2,
                                    )
                                  : Text("no image")),
                          Text(
                            e.name!,
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
      return Text("nodata");
    });
  }
}
