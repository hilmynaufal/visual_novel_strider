import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/playground_controller.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';
import 'package:visual_novel_strider/widgets/button_widgets/rectangle_box_selection_button.dart';
import 'package:visual_novel_strider/widgets/page_widgets/new_route_protagonist_selection.dart';
import 'package:visual_novel_strider/widgets/route_detail_widget/abstract_route_settings.dart';
import 'package:visual_novel_strider/widgets/texteditting_controller_mixin.dart';

class NewRouteSettingsPage extends AbstractRouteSetings
    with TextEdittingControllerMixin {
  NewRouteSettingsPage(
      {Key? key, required this.item, required this.playgroundController})
      : super(
          key: key,
          title: "Routes Settings",
          subTitle: "Please configure your playtrough first:",
        ) {
    // final TextEditingController playthroughNameController =
    //     TextEditingController();
  }

  final PlaygroundController playgroundController;
  final DetailResult item;

  @override
  Widget build(BuildContext context) {
    return buildWidget(context, body: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Playthrough Name:",
            style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 4),
          TextField(
              controller: textEditingController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: "Ex. Save 1",
                hintStyle: TextStyle(color: Colors.grey[400]),
                suffixIcon: Icon(CupertinoIcons.pencil_ellipsis_rectangle),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1,
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide(
                      color: Colors.grey[600]!,
                      style: BorderStyle.solid,
                      width: 1,
                    )),
              )),
          SizedBox(height: 16),
          Text(
            "Route branching type:",
            style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 4),
          RectangleBoxSelectionButton(
            headerTitle: playgroundController.routeBranchType.value,
            icon: CupertinoIcons.down_arrow,
            onPressed: (() {}),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Characters Available",
            style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 8,
          ),
          ElevatedButton(
              onPressed: () {
                playgroundController.playthroughName.value =
                    textEditingController.text;
                Get.to(() => NewRouteProtagonistSelectionPage(
                    item: item, playgroundController: playgroundController));
              },
              style: ElevatedButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  padding: EdgeInsets.all(8),
                  elevation: 0,
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                      side: BorderSide(color: Colors.black, width: 1))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Protagonist",
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(
                    height: 60,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: item.characters!
                            .where((e) =>
                                e.vns
                                    .firstWhere(
                                        (element) => element.id == item.id)
                                    .role ==
                                "main")
                            .map((e) => Container(
                                  height: 40,
                                  width: 40,
                                  child: Image.network(e.image!.url),
                                  alignment: Alignment.center,
                                ))
                            .toList()
                            .cast<Widget>()),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Main Characters",
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(
                    height: 60,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: item.characters!
                            .where((e) =>
                                e.vns
                                    .firstWhere(
                                        (element) => element.id == item.id)
                                    .role ==
                                "primary")
                            .map((e) => Container(
                                  height: 40,
                                  width: 40,
                                  child: Image.network(e.image!.url),
                                  alignment: Alignment.center,
                                ))
                            .toList()
                            .cast<Widget>()),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Side Characters",
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(
                    height: 60,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: item.characters!
                            .where((e) =>
                                e.vns
                                    .firstWhere(
                                        (element) => element.id == item.id)
                                    .role ==
                                "side")
                            .map((e) => Container(
                                  height: 40,
                                  width: 40,
                                  child: Image.network(e.image!.url),
                                  alignment: Alignment.center,
                                ))
                            .toList()
                            .cast<Widget>()),
                  ),
                ],
              ))
        ],
      ),
    ]);
  }
}
