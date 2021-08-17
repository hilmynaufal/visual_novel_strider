import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'dart:io';

import '../model/character_result.dart';
import '../model/result.dart';

class SocketServer extends GetxController {
  String? type;
  late Socket socket;
  Rx<Result> result = Result(items: [], more: false, num: 0).obs;
  var isReady = false;
  StreamController<Result> controller = StreamController<Result>();
  StreamController<CharacterResult> characterController =
      StreamController<CharacterResult>();
  StreamController<Result> newReleasedController = StreamController<Result>();
  StreamController<Result> mostPopularController = StreamController<Result>();
  static const EOM = '\u0004';

  Function? functionCall;

  @override
  void onInit() async {
    super.onInit;
    await connect();
  }

  Future<void> connect() async {
    try {
      // socket = await Socket.connect("192.168.0.107", 19534);
      socket = await Socket.connect("api.vndb.org", 19534);
      print("Connected");
      String message = "";
      socket.add(
          utf8.encode('login{"protocol":1,"client":"test","clientver":3.0}'));
      socket.add(utf8.encode(EOM));
      result.bindStream(controller.stream);

      socket.listen((event) async {
        message += utf8.decode(event);
        log(message);
        if (message.endsWith("}" + EOM)) {
          // if (message.endsWith("}") || message == "ok") {
          //   controller.add(message);
          //   print(message);
          // }
          int delimiter = message.indexOf("{");

          if (result != null && type == "") {
            controller.add(Result.fromJson(jsonDecode(message
                .substring(delimiter)
                .replaceAll("\n", "")
                .replaceAll('\u0004', ""))));
          }

          if (type == "character") {
            print("masuk");
            CharacterResult test = CharacterResult.fromJson(jsonDecode(message
                .substring(delimiter)
                .replaceAll("\n", "")
                .replaceAll('\u0004', "")));
            await functionCall!.call();
            characterController.add(test);
          }

          if (type == "new") {
            print("new released query");
            Result temp = Result.fromJson(jsonDecode(message
                .substring(delimiter)
                .replaceAll("\n", "")
                .replaceAll('\u0004', "")));
            newReleasedController.add(temp);
            functionCall!.call();
          }

          if (type == "popular") {
            print("most popular query");
            Result temp = Result.fromJson(jsonDecode(message
                .substring(delimiter)
                .replaceAll("\n", "")
                .replaceAll('\u0004', "")));
            mostPopularController.add(temp);
          }

          isReady = true;
          message = "";
          update();
        }
      });
    } catch (e) {
      e.printError();
    }
  }

  Future<void> sendMessage(String query) async {
    type = "";
    // socket.add(utf8
    //     .encode('get vn basic,details,stats,tags (search ~ "' + query + '")'));
    socket.add(utf8.encode(
        'get vn basic,details,stats,tags,screens (search ~ "' + query + '")'));
    socket.add(utf8.encode(EOM));
    // socket.add(EOM);
  }

  Future<void> getCharaFromDatabase(
      int id, String query, Function a, String type) async {
    this.type = type;
    functionCall = a;
    socket.add(utf8.encode('get character basic,details,vns,traits (vn = ' +
        id.toString() +
        ') {"results":20, "page":1}'));
    socket.add(utf8.encode(EOM));
  }

  Future<void> getNewReleased(String type, Function f) async {
    this.type = type;
    functionCall = f;
    socket.add(utf8.encode(
        ('get vn basic,details,stats,tags,screens (released<="2021-07-30" and released>="2021-07-25" and orig_lang="ja") {"results":20, "sort":"released", "reverse":true}')));
    socket.add(utf8.encode(EOM));
  }

  Future<void> getMostPopular(String type) async {
    this.type = type;
    socket.add(utf8.encode(
        ('get vn basic,details,stats,tags,screens (title ~ ""){"results":20, "sort":"popularity", "reverse":true}')));
    socket.add(utf8.encode(EOM));
  }

  void atest() {}
}
