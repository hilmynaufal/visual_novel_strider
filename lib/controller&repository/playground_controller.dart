import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:visual_novel_strider/controller&repository/abstract_card_persistent_controller.dart';
import 'package:visual_novel_strider/model/kana_model/branch_node_model.dart';
import 'package:visual_novel_strider/model/kana_model/choice_model.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';
import 'package:visual_novel_strider/model/kana_model/individual_result.dart';
import 'package:visual_novel_strider/model/kana_model/node_model.dart';
import 'package:visual_novel_strider/model/playground_model.dart';

class PlaygroundController extends AbstractCardPersistentController {
  PlaygroundController({required this.detailResult});
  late Box<PlaygroundModel> playgroundBox;

  //list of playthrough model
  final playthroughModels = RxList<PlaygroundModel>();
  //in selected playthrough model
  final curentPlaythrough = Rxn<PlaygroundModel>();

  RxBool isBoxReady = false.obs;
  RxBool isReady = false.obs;

  //playthrough properties
  RxString routeBranchType = "".obs;
  RxString playthroughName = "".obs;

  //node properties
  RxString nodeType = "".obs;

  //vn info
  DetailResult detailResult;

  //main route model to use in playground
  final routes = RxList<dynamic>();

  final currentNode = Rxn<dynamic>();

  @override
  void onInit() async {
    super.onInit();
    playgroundBox = await Hive.openBox('playground');
    isBoxReady.value = true;
    // await getPlaythroughList(currentNode.value!.vnId);
  }

  Future<void> getPlaythroughList(String vnId) async {
    playthroughModels.value =
        playgroundBox.values.where((element) => element.vnId == vnId).toList();
    isReady.value = true;
    update();
  }

  Future<void> addNewPlaythrough({required Function whenComplete}) async {
    PlaygroundModel playthroughModel = PlaygroundModel(
        id: currentNode.value!.vnId +
            playthroughName.value.removeAllWhitespace +
            currentNode.value!.createdAt.toString(),
        name: playthroughName.value,
        vnId: currentNode.value!.vnId,
        eventNodes: [currentNode.value!],
        createdAt: currentNode.value!.createdAt.toString(),
        isFinished: false,
        lastPlayed: currentNode.value!.lastPlayed.toString(),
        branchNodes: [],
        route: currentNode.value!.id);
    await playgroundBox.add(playthroughModel);
    curentPlaythrough.value = playthroughModel;
    await whenComplete.call();
    getPlaythroughList(currentNode.value!.vnId);
  }

  void createNewNodePreview(IndividualResult character, String vnId) {
    final now = DateTime.now();
    currentNode.value = EventNodeModel(
        id: 'e0',
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
  }

  void maintainingRoute() {
    // curentPlaythrough.value!.route = "e0-b0";
    // curentPlaythrough.value!.save();
    List<String> routesString = curentPlaythrough.value!.route.split('-');
    routes.value = routesString.map((e) {
      if (e.contains('b')) {
        final branchAndSelected = e.split(":");
        return curentPlaythrough.value!.branchNodes
            .firstWhere((element) => element.id == branchAndSelected[0]);
      }
      return curentPlaythrough.value!.eventNodes
          .firstWhere((element) => element.id == e);
    }).toList();
    log(routesString.toString());
    log(routes.length.toString());
    // update();
  }

  void selectChoice(ChoiceModel choiceModel, BranchNodeModel branchNodeModel) {
    choiceModel.isSelected = true.toString();
    branchNodeModel.hasSelected = true;
    final test = '${branchNodeModel.id}:${choiceModel.id}';
    curentPlaythrough.value!.route =
        curentPlaythrough.value!.route.replaceFirst(branchNodeModel.id, test);
    curentPlaythrough.value!.save();
    maintainingRoute();
  }

  void deselectChoice(
      ChoiceModel choiceModel, BranchNodeModel branchNodeModel) {
    choiceModel.isSelected = false.toString();
    branchNodeModel.hasSelected = false;
    // curentPlaythrough.value!.save();
    final test = '${branchNodeModel.id}:${choiceModel.id}';
    curentPlaythrough.value!.route =
        curentPlaythrough.value!.route.replaceFirst(test, branchNodeModel.id);
    curentPlaythrough.value!.save();
    maintainingRoute();
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
