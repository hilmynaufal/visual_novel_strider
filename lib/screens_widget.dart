import 'package:flutter/material.dart';
import 'package:visual_novel_strider/screen.dart';

class ScreensWidget extends StatelessWidget {
  ScreensWidget({Key? key, required this.screenshot}) : super(key: key);

  List<Screen>? screenshot;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
          // shrinkWrap: true,
          // physics: ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: screenshot!.length,
          itemBuilder: (context, index) =>
              (screenshot![index].flagging!.sexualAvg! +
                          screenshot![index].flagging!.violenceAvg! ==
                      0)
                  ? Container(
                      width: 300,
                      margin: EdgeInsets.only(right: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          screenshot![index].image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container()),
    );
  }
}
