import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/model/kana_model/choice_model.dart';

class BranchNodeChoiceSelectionCard extends StatelessWidget {
  const BranchNodeChoiceSelectionCard(
      {Key? key, required this.choice, required this.onTap})
      : super(key: key);

  final ChoiceModel choice;
  final void Function(ChoiceModel choiceModel)? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      // height: 80,
      child: FractionallySizedBox(
        widthFactor: 0.95,
        // heightFactor: 0.95,
        child: ElevatedButton(
            onPressed: () {
              if (onTap != null) {
                onTap?.call(choice);
              }
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: Color(choice.hexColor),
                elevation: 4,
                padding: const EdgeInsets.all(10)),
            child: Row(
              children: [
                Container(
                    margin: const EdgeInsets.all(8),
                    clipBehavior: Clip.antiAlias,
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: FadeInImage.memoryNetwork(
                      image: choice.character.image!.url,
                      alignment: Alignment.topCenter,
                      fit: BoxFit.none,
                      imageScale: 2,
                      placeholder: kTransparentImage,
                    )),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '"${choice.choiceOrig}"',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      Text(
                        '"${choice.choiceTrans}"',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.w200, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
