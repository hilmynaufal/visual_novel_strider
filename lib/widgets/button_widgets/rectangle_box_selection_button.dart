import 'package:flutter/material.dart';

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
          foregroundColor: Colors.black,
          padding: const EdgeInsets.all(8),
          backgroundColor: Colors.white,
          elevation: 0,
          shape: const RoundedRectangleBorder(
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
                  style: const TextStyle(fontSize: 14),
                ),
                description != null
                    ? Text(
                        description ?? "",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[400]),
                      )
                    : const SizedBox()
              ],
            ),
            const SizedBox(
              width: 8,
            )
          ],
        ));
  }
}
