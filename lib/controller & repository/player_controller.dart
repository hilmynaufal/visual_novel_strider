import 'package:get/get.dart';
import 'package:visual_novel_strider/hive_repository.dart';

class PlayerController extends GetxController {
  final HiveRepository _hiveRepository = Get.find();

  void addPlayTime(String playtime, int id) {
    _hiveRepository
        .result[
            _hiveRepository.result.indexWhere((element) => element.id == id)]
        .playtime = playtime;
  }
}
