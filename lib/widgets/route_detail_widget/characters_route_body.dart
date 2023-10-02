import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/playground_controller.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';
import 'package:visual_novel_strider/utils/datetime_parse.dart';
import 'package:visual_novel_strider/widgets/playground/route_playground_page.dart';

class CharactersRouteBody extends StatelessWidget {
  const CharactersRouteBody({Key? key, required this.item}) : super(key: key);

  final DetailResult item;

  // final NotificationController _notificationController = Get.find();
  // final PlaygroundController playgroundController = Get.find();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child:
              GetBuilder<PlaygroundController>(builder: (playgroundController) {
            if (playgroundController.playthroughModels.isEmpty) {
              // _notificationController.hiveRepository
              //     .getProgressDataWithVNId(item.id);
              playgroundController.getPlaythroughList(item.id);

              return const Center(
                  child: Text("Open Character's Drawer to Add Route Card"));
            }
            return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: playgroundController.playthroughModels.length,
                itemBuilder: (context, index) {
                  final playground =
                      playgroundController.playthroughModels[index];
                  return SizedBox(
                      height: 120,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ElevatedButton(
                            onPressed: () {
                              playgroundController.curentPlaythrough.value =
                                  playgroundController.playthroughModels[index];
                              playgroundController.currentNode.value =
                                  playgroundController.curentPlaythrough.value!
                                      .eventNodes.first;
                              Get.to(() => const RoutePlaygroundPage());
                            },
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                elevation: 4,
                                backgroundColor: theme.primaryColorLight,
                                padding: EdgeInsets.zero,
                                splashFactory: NoSplash.splashFactory,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8))),
                            child: Row(
                              children: [
                                Container(
                                  width: 12,
                                  color: theme.primaryColor,
                                  child: Container(
                                    margin: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          playground.name,
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          playground
                                              .eventNodes.last.character!.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                          overflow: TextOverflow.fade,
                                        ),
                                        Text(
                                          'Last Played: ${DateTimeParse.parseDateTime(playground.lastPlayed)}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black38,
                                              fontSize: 10),
                                          overflow: TextOverflow.fade,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Image.network(
                                      playground.eventNodes.last.character!
                                          .image!.url,
                                      alignment: Alignment.topCenter,
                                      fit: BoxFit.none,
                                      scale: 1.4),
                                )
                              ],
                            )),
                      )); //TODO: fix
                });
          }),
        ),
      ],
    );
  }
}
