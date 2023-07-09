import 'package:backdrop/backdrop.dart';
import 'package:flutter/cupertino.dart';
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
              padding: const EdgeInsets.all(10),
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
                          image: _.nowPlaying!.character!.image!.url),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        "Now Playing",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
              color: _theme.primaryColor,
            ),
          ),
        );
      }
      return const BackdropSubHeader(
          padding: EdgeInsets.all(0),
          automaticallyImplyTrailing: false,
          title: BackdropToggleButton(
            icon: AnimatedIcons.close_menu,
            color: Colors.grey,
          ));
    });
  }
}
