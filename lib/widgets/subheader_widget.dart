import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/controller&repository/player_controller.dart';

class SubHeaderWidget extends StatelessWidget {
  const SubHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
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
              color: theme.primaryColor,
              child: Row(
                children: [
                  SizedBox(
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
                  const Row(
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
            ),
          ),
        );
      }
      return Center(
        child: GestureDetector(
          onVerticalDragEnd: (details) {
            Backdrop.of(context).fling();
          },
          child: Container(
            width: double.infinity,
            color: theme.primaryColor,
            height: 30,
            child: Icon(
              Icons.drag_handle,
              color: theme.primaryColorLight,
            ),
          ),
        ),
      );
    });
  }
}
