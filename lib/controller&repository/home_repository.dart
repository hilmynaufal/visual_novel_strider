import 'package:get/get.dart';
import 'package:visual_novel_strider/service/socket_server.dart';

import '../model/result.dart';

class HomeRepository extends GetxController {
  final SocketServer server = Get.find();

  Rx<Result> result = Result(items: [], more: false, num: 0).obs;
  Rx<Result> popularResult = Result(items: [], more: false, num: 0).obs;
  Rx<Result> nakigeResult = Result(items: [], more: false, num: 0).obs;

  RxBool isReady = false.obs;

  @override
  void onReady() async {
    result.bindStream(server.newReleasedController.stream);
    popularResult.bindStream(server.mostPopularController.stream);
    nakigeResult.bindStream(server.nakigeController.stream);
  }

  Future<void> getNewReleased() async {
    result.value = Result(items: [], more: false, num: 0);
    isReady.value = false;
    await server.getNewReleased("new", () {
      getMostPopular();
    });
    update();
  }

  Future<void> getMostPopular() async {
    popularResult.value = Result(items: [], more: false, num: 0);
    isReady.value = false;
    await server.getMostPopular("popular", () {
      getNakige();
    });
    // update();
  }

  Future<void> getNakige() async {
    nakigeResult.value = Result(items: [], more: false, num: 0);
    isReady.value = false;
    await server.getNakige("nakige");
    isReady.value = true;
    update();
  }
}
