// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:backdrop/backdrop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:visual_novel_strider/hive_repository.dart';
import 'package:visual_novel_strider/http_client.dart';
import 'package:visual_novel_strider/inventory_widget.dart';
import 'package:visual_novel_strider/item_widget.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/links.dart';
import 'package:visual_novel_strider/model/hive_model/hive_characters_model.dart';
import 'package:visual_novel_strider/model/hive_model/hive_model.dart';
import 'package:visual_novel_strider/model/image_flagging.dart';
import 'package:visual_novel_strider/model/screen.dart';
import 'package:visual_novel_strider/socket_server.dart';
import 'package:visual_novel_strider/tags_repository.dart';
import 'package:visual_novel_strider/vn_detail.dart';
import 'package:visual_novel_strider/widgets/home_widget.dart';
import 'package:visual_novel_strider/widgets/search_widget.dart';

import 'characters_repository.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HiveVNModelAdapter());
  Hive.registerAdapter(HiveCHaractersModelAdapter());
  Hive.registerAdapter(LinksAdapter());
  Hive.registerAdapter(ImageFlaggingAdapter());
  Hive.registerAdapter(ScreenAdapter());
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
            primaryColor: const Color(0xFF29b6f6),
            brightness: Brightness.light,
            textTheme: TextTheme(),
            primaryColorLight: const Color(0xFF73e8ff),
            accentColor: Colors.white,
            primaryColorDark: const Color(0xFF0086c3),
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
  final HttpClient _httpClient = HttpClient();

  final SocketServer _serverSocket = Get.put(SocketServer());
  final TagsRepository _tagsRepository = Get.put(TagsRepository());
  final CharactersRepository _charactersRepository =
      Get.put(CharactersRepository());
  final HiveRepository _hiveRepository = Get.put(HiveRepository());

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // _httpClient.getTags();
    final _theme = Theme.of(context);

    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: _theme.primaryColor,
        backgroundColor: Colors.white,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        iconSize: 20,
        onTap: onItemTapped,
        currentIndex: _selectedIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.bag,
            ),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
            ),
            label: 'Chats',
          ),
        ],
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // ignore: prefer_final_fields
  static List<Widget> _pages = <Widget>[
    SearchWidget(),
    InventoryWidget(),
    HomeWidget()
  ];
}
