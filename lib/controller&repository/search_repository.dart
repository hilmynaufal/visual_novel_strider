import 'package:get/get.dart';
import 'package:visual_novel_strider/model/kana_model/response_result.dart';
import 'package:visual_novel_strider/service/vndb_api_kana_v2.dart';

class SearchRepository extends GetxController {
  final KanaServer _kanaServer = Get.find();

  Rx<ResponseResult> searchResult =
      ResponseResult(results: [], more: false).obs;
  RxBool isReady = false.obs;

  @override
  void onReady() async {
    searchResult.bindStream(_kanaServer.searchController.stream);
  }

  Future<void> getSearchResult(String query) async {
    // log("query =" + query);
    await _kanaServer.searchVisualNovel(query);
    isReady.value = true;
    update();
  }
}
