import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/playground_controller.dart';
import 'package:visual_novel_strider/widgets/playground/route_playground_page.dart';

class PlaygroundCreationIntermediate extends StatelessWidget {
  const PlaygroundCreationIntermediate({
    Key? key,
  }) : super(key: key);

  // final PlaygroundController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
                width: 60, height: 60, child: CircularProgressIndicator()),
            const SizedBox(
              height: 16,
            ),
            GetBuilder<PlaygroundController>(builder: (controller) {
              if (controller.curentPlaythrough.value != null) {
                controller.redirectWithFunction(function: () {
                  Get.off(() => const RoutePlaygroundPage());
                });
                // Get.to(() => RoutePlaygroundPage());
                return const Center(
                  child: Text("Redirecting..."),
                );
              } else {
                // controller.getItem(controller.currentNode.value!.vnId);
                controller.addNewPlaythrough(whenComplete: () async {
                  await Future.delayed(const Duration(seconds: 3));
                  // Get.to(() => RoutePlaygroundPage());
                });
                return const Text("Creating playground...");
              }
            }),
          ],
        ),
      ),
    );
  }
}
