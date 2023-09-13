import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:visual_novel_strider/controller&repository/abstract_card_persistent_controller.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';
import 'package:visual_novel_strider/model/kana_model/individual_result.dart';
import 'package:visual_novel_strider/model/kana_model/node_model.dart';
import 'package:visual_novel_strider/model/playground_model.dart';

class PlaygroundController extends AbstractCardPersistentController {
  late Box<PlaygroundModel> playgroundBox;
  final playthroughModel = Rxn<PlaygroundModel>();
  RxBool isBoxReady = false.obs;
  RxBool isReady = false.obs;
  RxString routeBranchType = "".obs;
  final currentNode = Rxn<NodeModel>();
  RxString playthroughName = "".obs;

  @override
  void onInit() async {
    super.onInit();
    playgroundBox = await Hive.openBox('playground');
    isBoxReady.value = true;
    await getItem(currentNode.value!.vnId);
  }

  Future<void> getItem(String vnId) async {
    playthroughModel.value =
        playgroundBox.values.firstWhere((element) => element.vnId == vnId);
    log(playthroughModel.value!.id);
    isReady.value = true;
    update();
  }

  Future<void> addNewPlaythrough({required Function whenComplete}) async {
    PlaygroundModel playthroughModel = PlaygroundModel(
        id: playthroughName.value.removeAllWhitespace + currentNode.value!.id,
        name: playthroughName.value,
        vnId: currentNode.value!.vnId,
        nodes: [currentNode.value!],
        createdAt: currentNode.value!.lastPlayed.toString(),
        isFinished: false,
        lastPlayed: currentNode.value!.lastPlayed.toString());
    await playgroundBox.add(playthroughModel);
    await whenComplete.call();
    getItem(currentNode.value!.vnId);
  }

  void createNewNodePreview(
      String id, IndividualResult character, String vnId) {
    currentNode.value = NodeModel(
        id: id,
        character: character,
        playtime: "0 hours 0 minutes",
        lastPlayed: DateTime.now(),
        hexColor: hexColor.value,
        isCompleted: false,
        endTime: length.value.toString(),
        isPlaying: false,
        vnId: vnId,
        note: note);
  }

  Future<void> redirectWithFunction({required Function function}) async {
    await Future.delayed(
      const Duration(seconds: 3),
      () {
        function.call();
      },
    );
  }
}
