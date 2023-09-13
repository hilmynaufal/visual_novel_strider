import 'package:get/get.dart';

abstract class AbstractCardPersistentController extends GetxController {
  RxBool isPlaying = false.obs;

  RxInt hexColor = 0xFF29b6f6.obs;
  String reminder = "";
  RxBool hasReminder = false.obs;
  RxInt length = 1.obs;
  String note = "";
}
