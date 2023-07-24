import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class VNHighlightWidget extends StatelessWidget {
  const VNHighlightWidget(
      {Key? key,
      required this.imageAssetUrl,
      required this.title,
      required this.developer,
      required this.id})
      : super(key: key);

  final String imageAssetUrl, title, developer, id;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Image.asset(
            imageAssetUrl,
            fit: BoxFit.fitWidth,
            width: MediaQuery.of(context).size.width - 14,
          ),
          Container(
            width: 20,
            child: Icon(CupertinoIcons.arrow_left),
          ),
          Container(
            padding: EdgeInsets.all(8),
            width: 200,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "by",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                developer,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4,
              ),
            ]),
          )
        ],
      ),
    );
  }
}
