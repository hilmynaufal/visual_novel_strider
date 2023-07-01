import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/model/screen.dart';

class ScreensWidget extends StatelessWidget {
  const ScreensWidget({Key? key, required this.screenshot}) : super(key: key);

  final List<Screen>? screenshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
          // shrinkWrap: true,
          // physics: ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: screenshot!.length,
          itemBuilder: (context, index) =>
              (screenshot![index].flagging!.sexualAvg! <= 1 &&
                      screenshot![index].flagging!.violenceAvg! <= 1)
                  ? Container(
                      width: 340,
                      margin: const EdgeInsets.only(right: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: screenshot![index].image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container()),
    );
  }
}
