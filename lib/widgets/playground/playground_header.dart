import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/playground_controller.dart';

import '../character_card.dart';

class PlaygroundHeader extends StatelessWidget {
  PlaygroundHeader({Key? key}) : super(key: key);
  final PlaygroundController playgroundController = Get.find();

  @override
  Widget build(BuildContext context) {
    final _headerHeight = MediaQuery.of(context).size.height - 300;
    final _screenWidth = MediaQuery.of(context).size.width;
    final _theme = Theme.of(context);
    return SliverAppBar(
      elevation: 0,
      backgroundColor: _theme.accentColor,
      foregroundColor: Colors.black,
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Container(
            margin: const EdgeInsets.only(top: 20, bottom: 30),
            height: 255,
            child: ListView.builder(
              itemCount:
                  playgroundController.playthroughModel.value!.nodes.length,
              scrollDirection: Axis.horizontal,
              physics: const PageScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                    width: _screenWidth,
                    margin: EdgeInsets.only(bottom: 8),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.center,
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(playgroundController
                                        .playthroughModel
                                        .value!
                                        .nodes[index]
                                        .hexColor)),
                                child: Container(
                                    width: 18,
                                    height: 18,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Icon(
                                      CupertinoIcons.arrow_branch,
                                      size: 14,
                                      color: Color(playgroundController
                                          .playthroughModel
                                          .value!
                                          .nodes[index]
                                          .hexColor),
                                    )),
                              ),
                              Container(
                                height: 2,
                                width: 40,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                color: Color(playgroundController
                                    .playthroughModel
                                    .value!
                                    .nodes[index]
                                    .hexColor),
                              ),
                              Container(
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.center,
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(playgroundController
                                        .playthroughModel
                                        .value!
                                        .nodes[index]
                                        .hexColor)),
                                child: Container(
                                    width: 18,
                                    height: 18,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Icon(
                                      CupertinoIcons.play_circle,
                                      size: 14,
                                      color: Color(playgroundController
                                          .playthroughModel
                                          .value!
                                          .nodes[index]
                                          .hexColor),
                                    )),
                              ),
                              Container(
                                height: 2,
                                width: 40,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                color: Color(playgroundController
                                    .playthroughModel
                                    .value!
                                    .nodes[index]
                                    .hexColor),
                              ),
                              Container(
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.center,
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(playgroundController
                                        .playthroughModel
                                        .value!
                                        .nodes[index]
                                        .hexColor)),
                                child: Container(
                                    width: 18,
                                    height: 18,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Icon(
                                      CupertinoIcons.arrow_branch,
                                      size: 14,
                                      color: Color(playgroundController
                                          .playthroughModel
                                          .value!
                                          .nodes[index]
                                          .hexColor),
                                    )),
                              )
                            ]),
                        SizedBox(height: 4),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: CharacterCard(
                              nodeModel: playgroundController
                                  .playthroughModel.value!.nodes[index],
                            ),
                          ),
                        ),
                      ],
                    ));
              },
            )),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(20),
        child: Container(
            width: double.infinity,
            color: Colors.grey[100],
            child: Icon(
              Icons.drag_handle,
              color: Colors.black38,
            )),
      ),
    );
  }
}
