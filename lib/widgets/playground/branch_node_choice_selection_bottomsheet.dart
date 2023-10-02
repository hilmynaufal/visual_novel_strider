import 'package:flutter/material.dart';
import 'package:visual_novel_strider/model/kana_model/branch_node_model.dart';
import 'package:visual_novel_strider/model/kana_model/choice_model.dart';
import 'package:visual_novel_strider/widgets/playground/branch_node_choice_selection_card.dart';

class BranchNodeChoiceSelectionBottomsheet extends StatelessWidget {
  const BranchNodeChoiceSelectionBottomsheet(
      {Key? key, required this.branchNodeModel, required this.onChoiceTap})
      : super(key: key);

  final BranchNodeModel branchNodeModel;
  final void Function(ChoiceModel choiceModel) onChoiceTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          children: [
            const Text(
              "Multiple Choices",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: branchNodeModel.choices.length,
                itemBuilder: (context, index) {
                  return BranchNodeChoiceSelectionCard(
                    choice: branchNodeModel.choices[index],
                    onTap: onChoiceTap,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
