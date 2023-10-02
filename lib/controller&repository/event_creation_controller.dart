import 'dart:developer';

import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/abstract_card_persistent_controller.dart';
import 'package:visual_novel_strider/controller&repository/playground_controller.dart';
import 'package:visual_novel_strider/model/kana_model/branch_node_model.dart';
import 'package:visual_novel_strider/model/kana_model/choice_model.dart';
import 'package:visual_novel_strider/model/kana_model/individual_result.dart';
import 'package:visual_novel_strider/model/kana_model/node_model.dart';

class EventCreationController extends AbstractCardPersistentController {
  final newNodeType = ''.obs;
  final newChoices = RxList<ChoiceModel>();

  final eventNodePreview = Rxn<EventNodeModel>();

  void well() {
    log('barudak well');
  }

  void addNewChoice(
      String origText, String transText, IndividualResult character) {
    newChoices.add(ChoiceModel(
        id: "c${newChoices.length}",
        character: character,
        choiceOrig: origText,
        choiceTrans: transText,
        isSelected: false.toString(),
        hexColor: hexColor.value));
    update();
  }

  void createEventNodePreview(IndividualResult character, String vnId) {
    final now = DateTime.now();
    eventNodePreview.value = EventNodeModel(
        id: '',
        character: character,
        playtime: "0 hours 0 minutes",
        lastPlayed: now,
        hexColor: hexColor.value,
        isCompleted: false,
        endTime: length.value.toString(),
        isPlaying: false,
        vnId: vnId,
        note: note,
        nodeType: 'kinetic',
        createdAt: now);
    update();
  }

  void handleNodeCreation() {
    if (newChoices.isEmpty || eventNodePreview.value == null) {
      Get.snackbar("Empty!", "Please create the node first.");
    }

    if (newNodeType.value == 'branch') {
      addNewBranchNode();
    } else if (newNodeType.value == 'event') {
      addNewEventNode();
    }
  }

  void addNewEventNode() {
    final playgroundController = Get.find<PlaygroundController>();

    //make the id
    final id =
        'e${playgroundController.curentPlaythrough.value!.eventNodes.length}';

    //assign the id to preview
    eventNodePreview.value!.id = id;

    //add event to playthrough
    playgroundController.curentPlaythrough.value!.eventNodes
        .add(eventNodePreview.value!);

    //setting route in playthrough
    playgroundController.curentPlaythrough.value!.route =
        '${playgroundController.curentPlaythrough.value!.route}-$id';

    //save to hive
    playgroundController.curentPlaythrough.value!.save();

    //
    playgroundController.routes.add(eventNodePreview);
    Get.close(1);
    playgroundController.update();
  }

  void addNewBranchNode() {
    final playgroundController = Get.find<PlaygroundController>();

    //make the id
    final id =
        'b${playgroundController.curentPlaythrough.value!.branchNodes.length}';

    //make the object
    final newBranchNode = BranchNodeModel(
        id: id,
        createdAt: DateTime.now().toString(),
        hasSelected: false,
        vnid: playgroundController.detailResult.id,
        choices: newChoices,
        nodeType: newNodeType.value);

    //add branch to playthrough
    playgroundController.curentPlaythrough.value!.branchNodes
        .add(newBranchNode);

    //setting route in playthrough
    playgroundController.curentPlaythrough.value!.route =
        '${playgroundController.curentPlaythrough.value!.route}-$id';

    //save to hive
    playgroundController.curentPlaythrough.value!.save();

    //
    playgroundController.routes.add(newBranchNode);
    Get.close(1);
    playgroundController.update();
  }
}
