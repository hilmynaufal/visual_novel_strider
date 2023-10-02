import 'package:flutter/cupertino.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
