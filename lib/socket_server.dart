import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'dart:io';

import 'package:visual_novel_strider/result.dart';

class SocketServer extends GetxController {
  late Socket socket;
  Rx<Result>? result;
  var isReady = false;
  StreamController<Result> controller = StreamController<Result>();
  var EOM = '\u0004';

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> connect() async {
    try {
      // socket = await Socket.connect("192.168.0.107", 19534);
      socket = await Socket.connect("api.vndb.org", 19534);
      print("Connected");
      String message = "";

      socket.listen((event) {
        message += utf8.decode(event);
        log(message);
        if (message.endsWith("}" + EOM)) {
          // if (message.endsWith("}") || message == "ok") {
          //   controller.add(message);
          //   print(message);
          // }
          int delimiter = message.indexOf("{");

          if (result == null) {
            result = Rx<Result>(Result.fromJson(jsonDecode(message
                .substring(delimiter)
                .replaceAll("\n", "")
                .replaceAll('\u0004', ""))));
            result!.bindStream(controller.stream);
          }

          if (isReady) {
            controller.add(Result.fromJson(jsonDecode(message
                .substring(delimiter)
                .replaceAll("\n", "")
                .replaceAll('\u0004', ""))));
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
    socket.add(utf8.encode(
        'login{"protocol":1,"client":"test","clientver":3.0,"username":"hilmyblaze","password":"Darkside1masamune"}'));
    socket.add(utf8.encode(EOM));
    // socket.add(utf8
    //     .encode('get vn basic,details,stats,tags (search ~ "' + query + '")'));
    socket.add(utf8.encode(
        'get vn basic,details,stats,tags,screens (search ~ "' + query + '")'));
    socket.add(utf8.encode(EOM));
    // socket.add(EOM);
  }

  void atest() {}
}
