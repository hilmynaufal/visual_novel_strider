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

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
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
  final TextEditingController _searchController = TextEditingController();
  final HiveRepository _hiveRepository = Get.put(HiveRepository());

  @override
  Widget build(BuildContext context) {
    // _httpClient.getTags();

    return BackdropScaffold(
      headerHeight: MediaQuery.of(context).size.height - 320,
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
          icon: AnimatedIcons.list_view,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: TextField(
          cursorColor: Theme.of(context).accentColor,
          controller: _searchController,
          style: TextStyle(fontSize: 16, color: Theme.of(context).accentColor),
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Theme.of(context).accentColor),
            hintText: "Search visual novel",
            focusedBorder: UnderlineInputBorder(),
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
            await _serverSocket.connect();
            await _serverSocket.sendMessage(_searchController.text);
          }),
    );
  }
}
