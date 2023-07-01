// ignore_for_file: deprecated_member_use

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/controller&repository/player_controller.dart';
import 'package:visual_novel_strider/utils/duration_parse.dart';
import 'package:visual_novel_strider/widgets/player.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    return GetBuilder<PlayerController>(
      builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Now Playing",
              style: TextStyle(
                  fontSize: 22,
                  color: _theme.accentColor,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              height: 4,
              width: 140,
              color: _theme.accentColor,
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: FractionallySizedBox(
                  widthFactor: 0.85,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  fit: BoxFit.none,
                                  width: 60,
                                  height: 100,
                                  imageScale: 3,
                                  alignment: Alignment.topCenter,
                                  image: _.nowPlaying!.character!.image!),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _.nowPlaying!.character!.name!,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    _.nowPlaying!.character!.original!,
                                    style: const TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.watch_later_outlined,
                                        size: 14,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        formatDate(_.nowPlaying!.lastPlayed,
                                            [dd, ' ', M, ' ', yyyy]),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.gamepad_rounded,
                                        size: 14,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      GetBuilder<PlayerController>(
                                          builder: (_local) {
                                        return Text(
                                          _local.nowPlaying!.playtime,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                        );
                                      }),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.track_changes_outlined,
                                        size: 14,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        durationToString(_.nowPlaying!.endTime),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _.resumeTimer();
                                  },
                                  child: const Icon(
                                    Icons.play_arrow_rounded,
                                    size: 48,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _.pauseTimer();
                                  },
                                  child: const Icon(
                                    Icons.pause,
                                    size: 40,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _.stopPlaying();
                                  },
                                  child: Icon(
                                    Icons.stop,
                                    size: 48,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Player(),
                                const Text(
                                  "Time Elapsed",
                                  style: TextStyle(fontSize: 10),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 8,
                        onPrimary: Colors.white,
                        padding: const EdgeInsets.all(16),
                        primary: Color(_.nowPlaying!.hexColor),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                  )),
            ),
          ],
        );
      },
    );
  }

  String durationToString(String duration) {
    List<int> time = DurationParsing.durationStringToInt(duration);
    String temp =
        time[0].toString() + ' hour ' + time[1].toString() + ' minute';
    return temp;
  }
}
