import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/model/old_socket_model/item.dart';
import 'package:visual_novel_strider/model/old_socket_model/tags_result.dart';

import '../controller&repository/tags_repository.dart';
import '../model/kana_model/tag_result.dart';

class TagsWidget extends StatelessWidget {
  TagsWidget({Key? key, required this.tags}) : super(key: key);

  final List<TagResult> tags;

  // final TagsRepository _tagsRepository = Get.find();

  @override
  Widget build(BuildContext context) {
    // _tagsRepository.getTags(item.tags!);

    final _theme = Theme.of(context);

    return GetBuilder<TagsRepository>(builder: (_tags) {
      if (tags.isNotEmpty) {
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tags.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                height: 18,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side:
                            BorderSide(color: _theme.primaryColor, width: 0.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () {},
                    child: Text(
                      tags[index].name,
                      style:
                          TextStyle(fontSize: 12, color: _theme.primaryColor),
                    )),
              );
            });
      }
      return const Text("o");
    });
  }
}
