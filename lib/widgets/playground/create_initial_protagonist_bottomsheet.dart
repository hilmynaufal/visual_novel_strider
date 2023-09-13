import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/playground_controller.dart';

import '../../controller&repository/notification_controller.dart';
import '../../model/kana_model/individual_result.dart';
import '../abstract_create_bottomsheet.dart';

class CreateInitialProtagonistBottomSheet extends AbstractCreateBottomSheet {
  CreateInitialProtagonistBottomSheet(
      {Key? key,
      required IndividualResult e,
      required String vnID,
      required String title,
      required Function customCallbackForAddButton})
      : super(
            key: key,
            e: e,
            vnID: vnID,
            title: title,
            controller: Get.find<PlaygroundController>(),
            customCallbackForAddButton: customCallbackForAddButton);
}
