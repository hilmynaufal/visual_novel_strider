import 'package:get/get.dart';

class ServerController extends GetxController {
  var count = 0.obs;

  increment() => count++;
}
