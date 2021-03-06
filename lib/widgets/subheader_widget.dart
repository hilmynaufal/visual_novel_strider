import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/controller&repository/player_controller.dart';

class SubHeaderWidget extends StatelessWidget {
  const SubHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    return GetBuilder<PlayerController>(builder: (_) {
      if (_.isPlaying.value) {
        return GestureDetector(
          onTap: () {
            Backdrop.of(context).fling();
          },
          child: BackdropSubHeader(
            padding: EdgeInsets.zero,
            automaticallyImplyTrailing: false,
            title: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          fit: BoxFit.none,
                          imageScale: 5,
                          alignment: Alignment.topCenter,
                          image: _.nowPlaying!.character!.image!),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Playing",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
              color: _theme.primaryColor,
            ),
          ),
        );
      }
      return BackdropSubHeader(
          padding: EdgeInsets.all(0),
          automaticallyImplyTrailing: false,
          title: BackdropToggleButton(
            icon: AnimatedIcons.close_menu,
            color: Colors.grey,
          ));
    });
  }
}
