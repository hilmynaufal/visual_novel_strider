import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:visual_novel_strider/model/release_result.dart';
import 'dart:io';

import '../model/character_result.dart';
import '../model/result.dart';

class SocketServer extends GetxController {
  String? type;
  Socket? socket;
  Rx<Result> result = Result(items: [], more: false, num: 0).obs;
  RxBool isReady = false.obs;
  StreamController<Result> controller = StreamController<Result>();
  StreamController<CharacterResult> characterController =
      StreamController<CharacterResult>();
  StreamController<Result> newReleasedController = StreamController<Result>();
  StreamController<Result> mostPopularController = StreamController<Result>();
  StreamController<Result> nakigeController = StreamController<Result>();
  StreamController<ReleaseResult> firstReleaseController =
      StreamController<ReleaseResult>();
  // ignore: constant_identifier_names
  static const EOM = '\u0004';
  int newCounter = 0, popularCounter = 0;

  Function? functionCall;
  Function? nakigeFunctionCall;
  Function? firstReleaseFunctionCall;

  @override
  void onInit() async {
    super.onInit;
    await connect();
  }

  Future<void> connect() async {
    try {
      // socket = await Socket.connect("192.168.0.107", 19534);

      socket = await Socket.connect("51.15.19.21", 19534);
      isReady.value = true;
      String message = "";
      socket!.add(
          utf8.encode('login{"protocol":1,"client":"test","clientver":3.0}'));
      socket!.add(utf8.encode(EOM));
      result.bindStream(controller.stream);

      socket!.listen((event) async {
        message += utf8.decode(event);
        if (message.endsWith("}" + EOM)) {
          // if (message.endsWith("}") || message == "ok") {
          //   controller.add(message);
          //   print(message);
          // }
          int delimiter = message.indexOf("{");

          if (type == "") {
            controller.add(Result.fromJson(jsonDecode(message
                .substring(delimiter)
                .replaceAll("\n", "")
                .replaceAll('\u0004', ""))));
          }

          if (type == "character") {
            CharacterResult test = CharacterResult.fromJson(jsonDecode(message
                .substring(delimiter)
                .replaceAll("\n", "")
                .replaceAll('\u0004', "")));
            // await functionCall!.call();
            characterController.add(test);
            message = "";
            firstReleaseFunctionCall!.call();
          }

          if (type == "new") {
            newCounter++;
            Result temp = Result.fromJson(jsonDecode(message
                .substring(delimiter)
                .replaceAll("\n", "")
                .replaceAll('\u0004', "")));
            newReleasedController.add(temp);
            message = "";
            functionCall!.call();
          }

          if (type == "popular") {
            Result temp = Result.fromJson(jsonDecode(message
                .substring(delimiter)
                .replaceAll("\n", "")
                .replaceAll('\u0004', "")));
            mostPopularController.add(temp);

            nakigeFunctionCall!.call();
          }

          if (type == "nakige") {
            // log(message);
            Result temp = Result.fromJson(jsonDecode(message
                .substring(delimiter)
                .replaceAll("\n", "")
                .replaceAll('\u0004', "")));
            nakigeController.add(temp);
          }

          if (type == "release") {
            ReleaseResult temp = ReleaseResult.fromJson(jsonDecode(message
                .replaceAll("results ", "")
                .replaceAll("\n", "")
                .replaceAll('\u0004', "")));

            firstReleaseController.add(temp);
            functionCall!.call();
          }

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
    socket!.add(utf8.encode(
        'get vn basic,details,stats,tags,screens (search ~ "' + query + '")'));
    socket!.add(utf8.encode(EOM));
    // socket.add(EOM);
  }

  Future<void> getCharaFromDatabase(
      int id, String query, Function a, String type) async {
    this.type = type;
    firstReleaseFunctionCall = a;
    socket!.add(utf8.encode('get character basic,details,vns,traits (vn = ' +
        id.toString() +
        ') {"results":20, "page":1}'));
    socket!.add(utf8.encode(EOM));
  }

  Future<void> getNewReleased(String type, Function f) async {
    this.type = type;
    functionCall = f;
    socket!.add(utf8.encode(
        ('get vn basic,details,stats,tags,screens (released<="2021-11-30" and released>="2021-11-25" and orig_lang="ja") {"results":20, "sort":"released", "reverse":true}')));
    socket!.add(utf8.encode(EOM));
  }

  Future<void> getMostPopular(String type, Function f) async {
    popularCounter++;
    this.type = type;
    nakigeFunctionCall = f;
    socket!.add(utf8.encode(
        ('get vn basic,details,stats,tags,screens (title ~ ""){"results":20, "sort":"popularity", "reverse":true}')));
    socket!.add(utf8.encode(EOM));
  }

  Future<void> getNakige(String type) async {
    this.type = type;
    socket!.add(utf8.encode(
        ('get vn basic,details,stats,tags,screens (tags = [596] and orig_lang = ["ja"]) {"results":20, "sort":"rating", "reverse":true}')));
    socket!.add(utf8.encode(EOM));
  }

  Future<void> getRelease(String type, int id, Function a) async {
    this.type = type;
    functionCall = a;
    socket!.add(utf8.encode(
        ('get release basic,details,producers (vn=$id and type="complete") {"sort":"released","reverse":false, "results":1}')));
    socket!.add(utf8.encode(EOM));
  }

  void atest() {}
}
