import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/notification_controller.dart';
import 'package:visual_novel_strider/model/kana_model/individual_result.dart';
import 'package:visual_novel_strider/widgets/abstract_create_bottomsheet.dart';

class CreateCardBottomSheet extends AbstractCreateBottomSheet {
  CreateCardBottomSheet({
    Key? key,
    required IndividualResult e,
    required String vnID,
    required String title,
  }) : super(
            key: key,
            e: e,
            vnID: vnID,
            title: title,
            controller: Get.find<NotificationController>());
}
