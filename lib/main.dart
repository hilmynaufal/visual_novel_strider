// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        ledColor: Colors.yellow)
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
            textSelectionColor: Colors.white,
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
      headerHeight: MediaQuery.of(context).size.height - 360,
      frontLayerBackgroundColor: Theme.of(context).accentColor,
      subHeader: Center(
        child: Container(
          child: BackdropToggleButton(
            icon: AnimatedIcons.close_menu,
            color: Colors.grey,
          ),
        ),
      ),
      backgroundColor: Colors.white,
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
              onPressed: () {
                Backdrop.of(context).fling();
                setState(() {
                  _selectedIndex = 2;
                });
              },
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
                  Text("Search",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      )),
                ],
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
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
                setState(() {
                  _selectedIndex = 1;
                });
              },
            )
          ],
        ),
      ),
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
                _selectedIndex = 0;
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
    SearchWidget(),
    InventoryWidget(),
    HomeWidget(),
  ];
}
