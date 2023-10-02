import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class DottedAddButton extends StatelessWidget {
  const DottedAddButton({Key? key, this.title, this.onTap, this.iconSize = 64})
      : super(key: key);

  final String? title;
  final void Function()? onTap;
  final double iconSize;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FractionallySizedBox(
        widthFactor: 0.95,
        heightFactor: 0.95,
        child: DottedBorder(
          borderType: BorderType.RRect,
          strokeCap: StrokeCap.butt,
          dashPattern: const [8, 2, 8, 2],
          color: Colors.grey[400]!,
          strokeWidth: 4,
          radius: const Radius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_box_outlined,
                    size: iconSize,
                    color: Colors.grey[300],
                  ),
                  title == null
                      ? const SizedBox()
                      : Text(
                          title!,
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
