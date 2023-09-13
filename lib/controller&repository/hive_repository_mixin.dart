import 'package:get/get.dart';

import 'hive_repository.dart';

//use to inject HiveRepository to any controller
mixin HiveRepositoryMixin {
  final HiveRepository hiveRepository = Get.find();
}
