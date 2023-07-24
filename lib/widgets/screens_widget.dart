import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/model/kana_model/screenshot_result.dart';

class ScreensWidget extends StatelessWidget {
  const ScreensWidget({Key? key, required this.screenshot}) : super(key: key);

  final List<Screenshot>? screenshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: ListView.builder(
            // shrinkWrap: true,
            // physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: screenshot!.length,
            itemBuilder: (_, index) => Row(
                  children: [
                    index == 0
                        ? const SizedBox(
                            width: 16,
                          )
                        : Container(),
                    Container(
                      width: 340,
                      margin: const EdgeInsets.only(right: 8),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border.all(color: Colors.grey[300]!)),
                      child: FancyShimmerImage(
                        imageUrl: screenshot![index].url!,
                        boxFit: BoxFit.cover,
                      ),
                    ),
                    index == screenshot!.length - 1
                        ? const SizedBox(
                            width: 16,
                          )
                        : Container()
                  ],
                )));
  }
}
