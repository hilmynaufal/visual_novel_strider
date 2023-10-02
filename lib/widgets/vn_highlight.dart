import 'package:flutter/cupertino.dart';

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
          const SizedBox(
            width: 20,
            child: Icon(CupertinoIcons.arrow_left),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            width: 200,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const Text(
                "by",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                developer,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 4,
              ),
            ]),
          )
        ],
      ),
    );
  }
}
