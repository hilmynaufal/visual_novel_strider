import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';
import 'package:visual_novel_strider/widgets/route_detail_widget/characters_drawer.dart';

class RoutesMakerBody extends StatelessWidget {
  const RoutesMakerBody({Key? key, required this.item}) : super(key: key);

  final DetailResult item;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: GestureDetector(
          onTap: () {
            Get.bottomSheet(CharactersDrawer(item: item));
          },
          child: DottedBorder(
            borderType: BorderType.RRect,
            strokeCap: StrokeCap.butt,
            dashPattern: [8, 2, 8, 2],
            color: Colors.grey[400]!,
            strokeWidth: 4,
            radius: Radius.circular(12),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_box_outlined,
                    size: 164,
                    color: Colors.grey[300],
                  ),
                  Text(
                    "Add new routes for this visual novel.",
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w800,
                        fontSize: 14),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
