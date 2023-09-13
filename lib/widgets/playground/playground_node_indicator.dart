import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PlaygroundNodeIndicator extends StatelessWidget {
  const PlaygroundNodeIndicator({Key? key, required this.isNextNode})
      : super(key: key);

  final bool isNextNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsets.all(2),
                alignment: Alignment.center,
                width: 20,
                height: 20,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
                child: Container(
                    width: 18,
                    height: 18,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Icon(
                      CupertinoIcons.arrow_branch,
                      size: 14,
                      color: Colors.amber,
                    )),
              ),
              isNextNode
                  ? SizedBox()
                  : Expanded(
                      child: Container(
                        width: 2,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        color: Colors.amber,
                      ),
                    ),
            ],
          ),
          SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Current Node",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
              ),
              Text(
                "Mitsukasa Ayase",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              Text(
                "Last Played: 2 Aug 2022",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}
