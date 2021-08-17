import 'package:backdrop/app_bar.dart';
import 'package:backdrop/button.dart';
import 'package:backdrop/scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'inventory_widget.dart';
import 'item_widget.dart';
import '../service/socket_server.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final SocketServer _serverSocket = Get.find();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: GetBuilder<SocketServer>(builder: (_controller) {
          if (!_controller.isReady) {
            return Text("No Data");
          }
          return const ItemWidget();
        }),
      ),
    );
  }
}
