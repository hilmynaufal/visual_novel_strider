import 'package:backdrop/app_bar.dart';
import 'package:backdrop/button.dart';
import 'package:backdrop/scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:visual_novel_strider/hive_repository.dart';

import '../characters_repository.dart';
import '../http_client.dart';
import 'inventory_widget.dart';
import '../item_widget.dart';
import '../socket_server.dart';
import '../tags_repository.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({Key? key}) : super(key: key);

  final SocketServer _serverSocket = Get.find();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return BackdropScaffold(
      frontLayerBackgroundColor: Theme.of(context).accentColor,
      headerHeight: MediaQuery.of(context).size.height - 320,
      subHeader: Center(
        child: Container(
          child: BackdropToggleButton(
            icon: AnimatedIcons.close_menu,
            color: Colors.grey,
          ),
        ),
      ),
      backLayer: Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                  primary: Theme.of(context).accentColor,
                  minimumSize: Size(double.infinity, 50)),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.home,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Home",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                      )),
                ],
              ),
              onPressed: () {},
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  primary: Theme.of(context).accentColor,
                  minimumSize: Size(double.infinity, 50)),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.search,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Catalog",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      )),
                ],
              ),
              onPressed: () {},
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                  primary: Theme.of(context).accentColor,
                  minimumSize: Size(double.infinity, 50)),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.bag,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Inventory",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      )),
                ],
              ),
              onPressed: () {
                Get.to(() => InventoryWidget());
              },
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: BackdropAppBar(
        leading: const BackdropToggleButton(
          icon: AnimatedIcons.close_menu,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: TextField(
          cursorColor: Theme.of(context).accentColor,
          controller: _searchController,
          style: TextStyle(fontSize: 16, color: Theme.of(context).accentColor),
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Theme.of(context).accentColor),
            hintText: "Search visual novel",
            prefixIcon: Icon(
              CupertinoIcons.search,
              size: 16,
              color: Theme.of(context).accentColor,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
      frontLayer: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: GetBuilder<SocketServer>(builder: (_controller) {
            if (!_controller.isReady) {
              return Text("No Data");
            }
            return const ItemWidget();
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            CupertinoIcons.search,
            color: Theme.of(context).accentColor,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () async {
            if (_searchController.text.isNotEmpty) {
              await _serverSocket.sendMessage(_searchController.text);
            }
          }),
      backLayerScrim: Colors.transparent,
    );
  }
}
