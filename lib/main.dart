// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'package:backdrop/backdrop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:visual_novel_strider/hive_repository.dart';
import 'package:visual_novel_strider/http_client.dart';
import 'package:visual_novel_strider/notification_service.dart';
import 'package:visual_novel_strider/widgets/inventory_widget.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
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
        darkTheme: ThemeData(
            primaryColor: Colors.black,
            brightness: Brightness.dark,
            accentColor: const Color(0xFF29b6f6),
            fontFamily: 'Nunito'),
        theme: ThemeData(
            primaryColor: const Color(0xFF29b6f6),
            brightness: Brightness.light,
            textTheme: TextTheme(headline1: TextStyle(color: Colors.white)),
            primaryColorLight: const Color(0xFF68CEFE),
            accentColor: Colors.white,
            primaryColorDark: const Color(0xFF29b6f6),
            textSelectionColor: Colors.white,
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
        backgroundColor: _theme.accentColor,
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
