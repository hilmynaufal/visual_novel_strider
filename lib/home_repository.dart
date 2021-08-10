import 'package:get/get.dart';
import 'package:visual_novel_strider/socket_server.dart';

import 'model/result.dart';

class HomeRepository extends GetxController {
  final SocketServer _server = Get.find();

  Rx<Result> result = Result(items: [], more: false, num: 0).obs;

  RxBool isReady = false.obs;

  @override
  void onReady() {
    result.bindStream(_server.newReleasedController.stream);
  }

  void getNewReleased() async {
    result.value = Result(items: [], more: false, num: 0);
    isReady.value = false;
    await _server.getNewReleased("new");
    isReady.value = true;
    update();
  }
}
