import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:visual_novel_strider/controller&repository/hive_repository.dart';
import 'package:visual_novel_strider/model/hive_model/progress_model.dart';

class PlayerController extends GetxController {
  final HiveRepository hiveRepository = Get.find();
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  StopWatchTimer get stopWatchTimer => _stopWatchTimer;

  ProgressModel? _nowPlaying;
  ProgressModel? get nowPlaying => _nowPlaying;

  final RxInt _stopList = 0.obs;
  RxInt get stopList => _stopList;

  // RxInt minutes = 0.obs, seconds = 0.obs;
  RxBool isPlaying = false.obs;

  void addPlayTime(String playtime, int id) {
    hiveRepository
        .result[hiveRepository.result.indexWhere((element) => element.id == id)]
        .playtime = playtime;
  }

  @override
  void onReady() {
    // minutes.bindStream(_stopWatchTimer.minuteTime);
    // seconds.bindStream(_stopWatchTimer.rawTime);
  }

  void starTimer(int index) {
    isPlaying.value = true;
    hiveRepository.result[index].isPlaying = true;
    hiveRepository.result[index].save();
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    stopList.bindStream(_stopWatchTimer.rawTime);
    update();
  }
}
