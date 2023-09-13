import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/widgets/playground/route_playground_page.dart';

class RectangleBoxSelectionButton extends StatelessWidget {
  const RectangleBoxSelectionButton(
      {Key? key,
      required this.headerTitle,
      this.description,
      this.imgUrl,
      this.onPressed,
      this.icon})
      : super(key: key);

  final String headerTitle;
  final String? imgUrl, description;
  final IconData? icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(8),
          elevation: 0,
          primary: Colors.white,
          onPrimary: Colors.black,
          shape: RoundedRectangleBorder(
              side: BorderSide(
            color: Colors.black,
            width: 1,
          )),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 64,
              width: 64,
              child: imgUrl != null
                  ? Image.network(
                      imgUrl!,
                      fit: BoxFit.none,
                      alignment: Alignment.topCenter,
                      scale: 3,
                    )
                  : icon != null
                      ? Icon(icon)
                      : null,
            ),
            Column(
              children: [
                Text(
                  headerTitle,
                  style: TextStyle(fontSize: 14),
                ),
                description != null
                    ? Text(
                        description ?? "",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[400]),
                      )
                    : SizedBox()
              ],
            ),
            SizedBox(
              width: 8,
            )
          ],
        ));
  }
}
