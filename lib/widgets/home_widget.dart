import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return BackdropScaffold(
        appBar: BackdropAppBar(
          title: Text("Home"),
          backgroundColor: _theme.primaryColor,
        ),
        backLayer: Container(),
        frontLayer: Container());
  }
}
