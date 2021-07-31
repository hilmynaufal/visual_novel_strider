import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visual_novel_strider/item_widget.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/socket_server.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
            fontFamily: "Nunito"),
        home: const MyHome());
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    final SocketServer _serverSocket = Get.put(SocketServer());
    final TextEditingController _searchController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: TextField(
          controller: _searchController,
          style: const TextStyle(fontSize: 16),
          decoration: const InputDecoration(
            hintText: "Search visual novel",
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
      body: Container(
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
          child: const Icon(CupertinoIcons.search),
          onPressed: () async {
            await _serverSocket.connect();
            await _serverSocket.sendMessage(_searchController.text);
          }),
    );
  }
}
