import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/tag_info_repository.dart';

class TagInfoBottomsheet extends StatelessWidget {
  const TagInfoBottomsheet({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GetBuilder<TagInfoRepository>(
      builder: (controller) {
        if (controller.isReady.isFalse) {
          controller.getTagInfo(id);
          controller.getSimilarTagList(controller.currentTag.value!.id, id);
          return CircularProgressIndicator(
            color: theme.primaryColorDark,
          );
        }
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(controller.currentTag.value!.name),
              Text(controller.tagDescription),
              ListView(
                scrollDirection: Axis.horizontal,
                children: const [CircularProgressIndicator()],
              )
            ],
          ),
        );
      },
    );
  }
}
