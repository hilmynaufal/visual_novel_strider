// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, deprecated_member_use, unused_field

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:visual_novel_strider/controller&repository/player_controller.dart';
import 'package:visual_novel_strider/controller&repository/hive_repository.dart';
import 'package:visual_novel_strider/service/http_client.dart';
import 'package:visual_novel_strider/model/hive_model/progress_model.dart';
import 'package:visual_novel_strider/controller&repository/notification_controller.dart';
import 'package:visual_novel_strider/widgets/inventory_widget.dart';
import 'package:visual_novel_strider/widgets/item_widget.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/model/links.dart';
import 'package:visual_novel_strider/model/hive_model/hive_characters_model.dart';
import 'package:visual_novel_strider/model/hive_model/hive_model.dart';
import 'package:visual_novel_strider/model/image_flagging.dart';
import 'package:visual_novel_strider/model/screen.dart';
import 'package:visual_novel_strider/service/socket_server.dart';
import 'package:visual_novel_strider/controller&repository/tags_repository.dart';
import 'package:visual_novel_strider/widgets/player_card.dart';
import 'package:visual_novel_strider/widgets/subheader_widget.dart';
import 'package:visual_novel_strider/widgets/vn_detail.dart';
import 'package:visual_novel_strider/widgets/home_widget.dart';
import 'package:visual_novel_strider/widgets/search_widget.dart';

import 'controller&repository/characters_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await NotificationService().init();
  await Hive.initFlutter();
  Hive.registerAdapter(HiveVNModelAdapter());
  Hive.registerAdapter(HiveCHaractersModelAdapter());
  Hive.registerAdapter(LinksAdapter());
  Hive.registerAdapter(ImageFlaggingAdapter());
  Hive.registerAdapter(ScreenAdapter());
  Hive.registerAdapter(ProgressModelAdapter());
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'schedule_notification',
        channelName: 'Route Schedule Notification',
        channelDescription: 'Notification channel to send schedule reminder',
        channelShowBadge: true,
        onlyAlertOnce: true,
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.yellow),
    NotificationChannel(
        channelKey: 'media_player',
        channelName: 'Media player controller',
        channelDescription: 'Media player controller',
        channelShowBadge: true,
        onlyAlertOnce: true,
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.yellow,
        locked: true),
  ]);

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
            primaryColor: const Color(0xFF29b6f6),
            brightness: Brightness.light,
            textTheme: TextTheme(headline1: TextStyle(color: Colors.white)),
            primaryColorLight: const Color(0xFF68CEFE),
            accentColor: Colors.white,
            primaryColorDark: const Color(0xFF29b6f6),
            // textSelectionColor: Colors.white,
            fontFamily: "Nunito"),
        home: MyHome());
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final SocketServer _serverSocket = Get.put(SocketServer());
  final TagsRepository _tagsRepository = Get.put(TagsRepository());
  final CharactersRepository _charactersRepository =
      Get.put(CharactersRepository());
  final HiveRepository _hiveRepository = Get.put(HiveRepository());
  final NotificationController _controller = Get.put(NotificationController());
  final PlayerController _playerController = Get.put(PlayerController());

  final TextEditingController _searchController = TextEditingController();

  int _selectedIndex = 0;

  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    // _httpClient.getTags();
    final _theme = Theme.of(context);
    final _headerHeight = MediaQuery.of(context).size.height - 400;

    return BackdropScaffold(
      appBar: BackdropAppBar(
        leading: const BackdropToggleButton(
          icon: AnimatedIcons.close_menu,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: TextField(
          focusNode: myFocusNode,
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
      headerHeight: _headerHeight,
      frontLayerBackgroundColor: Theme.of(context).accentColor,
      subHeader: SubHeaderWidget(),
      subHeaderAlwaysActive: false,
      backgroundColor: Colors.white,
      backLayerBackgroundColor: _theme.primaryColor,
      backLayer: GetBuilder<PlayerController>(builder: (_) {
        if (_.nowPlaying == null) {
          return Container(
            margin: EdgeInsets.only(top: 40),
            width: double.infinity,
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Text(
                "when you are playing the character route, the card will appear here!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    color: _theme.accentColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
        return PlayerCard();
      }),
      frontLayer: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: BottomNavigationBar(
          selectedItemColor: _theme.primaryColor,
          backgroundColor: _theme.accentColor,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          iconSize: 22,
          onTap: onItemTapped,
          currentIndex: _selectedIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              activeIcon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cases_rounded),
              activeIcon: Icon(
                CupertinoIcons.bag,
              ),
              label: 'Inventory',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              activeIcon: Icon(Icons.explore_outlined),
              label: 'Search',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            CupertinoIcons.search,
            color: Theme.of(context).accentColor,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () async {
            if (!myFocusNode.hasFocus) {
              myFocusNode.requestFocus();
            } else if (_searchController.text.isNotEmpty &&
                myFocusNode.hasFocus) {
              setState(() {
                FocusManager.instance.primaryFocus!.unfocus();
                _selectedIndex = 2;
              });
              await _serverSocket.sendMessage(_searchController.text);
            }
          }),
      backLayerScrim: Colors.transparent,
    );
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ignore: prefer_final_fields
  static List<Widget> _pages = <Widget>[
    HomeWidget(),
    InventoryWidget(),
    SearchWidget(),
  ];
}
