import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/playground_controller.dart';
import 'package:visual_novel_strider/model/kana_model/node_model.dart';
import 'package:visual_novel_strider/widgets/button_widgets/dotted_add_button.dart';
import 'package:visual_novel_strider/widgets/playground/branch_choice_node_card.dart';
import 'package:visual_novel_strider/widgets/playground/choose_event_creation_page.dart';

import '../character_card.dart';

class PlaygroundHeader extends StatelessWidget {
  PlaygroundHeader({Key? key}) : super(key: key);
  final PlaygroundController playgroundController = Get.find();

  @override
  Widget build(BuildContext context) {
    playgroundController.maintainingRoute();
    // throw "t";
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return SliverAppBar(
      elevation: 0,
      backgroundColor: theme.primaryColorLight,
      foregroundColor: Colors.black,
      pinned: true,
      expandedHeight: 300,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  alignment: Alignment.center,
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(playgroundController
                          .curentPlaythrough.value!.eventNodes[0].hexColor)),
                  child: Container(
                      width: 18,
                      height: 18,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Icon(
                        CupertinoIcons.arrow_branch,
                        size: 14,
                        color: Color(playgroundController
                            .curentPlaythrough.value!.eventNodes[0].hexColor),
                      )),
                ),
                Container(
                  height: 2,
                  width: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  color: Color(playgroundController
                      .curentPlaythrough.value!.eventNodes[0].hexColor),
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  alignment: Alignment.center,
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(playgroundController
                          .curentPlaythrough.value!.eventNodes[0].hexColor)),
                  child: Container(
                      width: 18,
                      height: 18,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Icon(
                        CupertinoIcons.play_circle,
                        size: 14,
                        color: Color(playgroundController
                            .curentPlaythrough.value!.eventNodes[0].hexColor),
                      )),
                ),
                Container(
                  height: 2,
                  width: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  color: Color(playgroundController
                      .curentPlaythrough.value!.eventNodes[0].hexColor),
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  alignment: Alignment.center,
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(playgroundController
                          .curentPlaythrough.value!.eventNodes[0].hexColor)),
                  child: Container(
                      width: 18,
                      height: 18,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Icon(
                        CupertinoIcons.arrow_branch,
                        size: 14,
                        color: Color(playgroundController
                            .curentPlaythrough.value!.eventNodes[0].hexColor),
                      )),
                )
              ]),
            ),
            SizedBox(
                height: 255,
                child: Obx(() {
                  if (playgroundController.routes.isEmpty) {
                    playgroundController.maintainingRoute();
                    return const Center(
                      child: SizedBox(
                        width: 64,
                        height: 64,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: playgroundController.routes.length + 1,
                    scrollDirection: Axis.horizontal,
                    physics: const PageScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index == playgroundController.routes.length) {
                        return Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 20),
                            width: screenWidth,
                            child: DottedAddButton(
                              onTap: () {
                                Get.to(() => ChooseEventCreationPage(
                                    title: "Event Creation",
                                    subTitle:
                                        "Select the type of the event you want to create:"));
                              },
                              title: "Add Next!",
                              iconSize: 64,
                            ));
                      }
                      return Container(
                          width: screenWidth,
                          margin: const EdgeInsets.only(top: 10, bottom: 20),
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: playgroundController.routes[index]
                                      is EventNodeModel
                                  ? CharacterCard(
                                      nodeModel:
                                          playgroundController.routes[index],
                                      onCardPressed: () {},
                                    )
                                  : BranchChoiceNodeCard(
                                      index: index,
                                    )));
                    },
                  );
                })),
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(20),
        child: Container(
            width: double.infinity,
            color: Colors.grey[100],
            child: const Icon(
              Icons.drag_handle,
              color: Colors.black38,
            )),
      ),
    );
  }
}
