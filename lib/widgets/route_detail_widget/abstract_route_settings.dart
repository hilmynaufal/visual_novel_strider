import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../button_widgets/transparent_rounded_button.dart';
import '../page_widgets/new_route_protagonist_selection.dart';

abstract class AbstractRouteSetings extends StatelessWidget {
  const AbstractRouteSetings(
      {Key? key, required this.subTitle, required this.title})
      : super(key: key);

  final String title, subTitle;

  Widget buildWidget(BuildContext context, {required List<Widget> body}) {
    final _theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        toolbarHeight: 80,
        backgroundColor: _theme.accentColor,
      ),
      backgroundColor: _theme.accentColor,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 32),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                subTitle,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
              SizedBox(
                height: 16,
              ),
              ...body
            ],
          ),
        ),
      ),
    );
  }
}
