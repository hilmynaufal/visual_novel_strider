// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, deprecated_member_use, unused_field

import 'dart:io';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:visual_novel_strider/controller&repository/detail_repository.dart';
import 'package:visual_novel_strider/controller&repository/player_controller.dart';
import 'package:visual_novel_strider/controller&repository/hive_repository.dart';
import 'package:visual_novel_strider/controller&repository/search_repository.dart';
import 'package:visual_novel_strider/model/kana_model/image.dart' as ImageP;
import 'package:visual_novel_strider/model/kana_model/individual_result.dart';
import 'package:visual_novel_strider/model/kana_model/screenshot_result.dart';
import 'package:visual_novel_strider/model/kana_model/tag_result.dart';
import 'package:visual_novel_strider/model/kana_model/trait.dart';
import 'package:visual_novel_strider/model/kana_model/vns.dart';
import 'package:visual_novel_strider/service/http_client.dart';
import 'package:visual_novel_strider/model/hive_model/progress_model.dart';
import 'package:visual_novel_strider/controller&repository/notification_controller.dart';
import 'package:visual_novel_strider/service/vndb_api_kana_v2.dart';
import 'package:visual_novel_strider/utils/myhttpoverrides.dart';
import 'package:visual_novel_strider/widgets/empty_widget.dart';
import 'package:visual_novel_strider/widgets/inventory_widget.dart';
import 'package:visual_novel_strider/widgets/item_widget.dart';
import 'package:get/get.dart';
// import 'package:visual_novel_strider/model/links.dart';
import 'package:visual_novel_strider/model/hive_model/hive_characters_model.dart';
import 'package:visual_novel_strider/model/hive_model/hive_model.dart';
// import 'package:visual_novel_strider/model/image_flagging.dart';
// import 'package:visual_novel_strider/model/screen.dart';
import 'package:visual_novel_strider/service/socket_server.dart';
import 'package:visual_novel_strider/controller&repository/trait_repository.dart';
import 'package:visual_novel_strider/widgets/player_card.dart';
import 'package:visual_novel_strider/widgets/subheader_widget.dart';
import 'package:visual_novel_strider/widgets/vn_detail.dart';
import 'package:visual_novel_strider/widgets/home_widget.dart';
import 'package:visual_novel_strider/widgets/search_widget.dart';

import 'controller&repository/characters_repository.dart';
import 'model/kana_model/detail_result.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //http override bad ssl
  HttpOverrides.global = MyHttpOverrides();

  //navigation draw oerlay
  //Setting SysemUIOverlay
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    systemStatusBarContrastEnforced: true,
    // systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    // systemNavigationBarContrastEnforced: true,
    // systemNavigationBarColor: Colors.white,
    // statusBarColor: Color(0xFF29b6f6)
  ));

//Setting SystmeUIMode
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
  //     overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

  // await NotificationService().init();
  await Hive.initFlutter();
  Hive.registerAdapter(DetailResultAdapter());
  Hive.registerAdapter(IndividualResultAdapter());
  Hive.registerAdapter(TraitAdapter());
  Hive.registerAdapter(ImageP.ImageAdapter());
  Hive.registerAdapter(ScreenshotAdapter());
  Hive.registerAdapter(TagResultAdapter());
  Hive.registerAdapter(VnsAdapter());
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
        title: 'Visual Novel Strider',
        theme: ThemeData(
            primaryColor: const Color(0xFF29b6f6),
            brightness: Brightness.light,
            textTheme: TextTheme(headline1: TextStyle(color: Colors.white)),
            accentColor: Colors.white,
            primaryColorLight: const Color(0xFF68CEFE),
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
  // final SocketServer _serverSocket = Get.put(SocketServer());
  final KanaServer _kanaServer = Get.put(KanaServer());
  final SearchRepository _searchRepository = Get.put(SearchRepository());
  final DetailRepository _detailRepository = Get.put(DetailRepository());
  // final TagsRepository _tagsRepository = Get.put(TagsRepository());
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
      extendBody: true,
      appBar: BackdropAppBar(
        leading: Image.asset('assets/logo_small_invert_light.png'),
        backgroundColor: _theme.primaryColor,
        actions: [
          Icon(CupertinoIcons.search),
          SizedBox(
            width: 24,
          )
        ],
        title: TextField(
          focusNode: myFocusNode,
          cursorColor: Theme.of(context).accentColor,
          controller: _searchController,
          style: TextStyle(fontSize: 16, color: _theme.accentColor),
          decoration: InputDecoration(
            // isDense: true,
            // contentPadding: EdgeInsets.symmetric(vertical: 4),
            hintStyle: TextStyle(color: _theme.accentColor),
            hintText: "Search visual novel",
            prefixIcon: Icon(
              CupertinoIcons.search,
              size: 16,
              color: Theme.of(context).accentColor,
            ),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            // disabledBorder: InputBorder.none,
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
                "When you are playing a character route, i'ts card will shows here!",
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _theme.primaryColor,
        backgroundColor: _theme.accentColor,
        elevation: 0,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey[600],
        iconSize: 20,
        onTap: onItemTapped,
        selectedLabelStyle: _bottomNavItemTextStyle(selected: true),
        unselectedLabelStyle: _bottomNavItemTextStyle(selected: false),
        currentIndex: _selectedIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
            activeIcon: Icon(CupertinoIcons.house_fill),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bag),
            activeIcon: Icon(
              CupertinoIcons.bag_fill,
            ),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.gear_alt),
            activeIcon: Icon(CupertinoIcons.gear_alt_fill),
            label: 'Settings',
          ),
        ],
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
              await _searchRepository.getSearchResult(_searchController.text);
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
    EmptyWidget(
      text: "Settings",
    )
  ];

  TextStyle _bottomNavItemTextStyle({required bool selected}) {
    switch (selected) {
      case true:
        return TextStyle(fontWeight: FontWeight.w800);
      default:
        return TextStyle(fontWeight: FontWeight.w600);
    }
  }
}
