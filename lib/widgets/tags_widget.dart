import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/model/item.dart';
import 'package:visual_novel_strider/service/socket_server.dart';

import '../controller&repository/tags_repository.dart';

class TagsWidget extends StatelessWidget {
  TagsWidget({Key? key, required this.item}) : super(key: key);

  final Item item;

  final TagsRepository _tagsRepository = Get.find();

  final SocketServer _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    _tagsRepository.getTags(item.tags!);

    final _theme = Theme.of(context);

    return GetBuilder<TagsRepository>(builder: (_tags) {
      if (_tags.isReady) {
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _tags.entity.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                height: 18,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side:
                            BorderSide(color: _theme.primaryColor, width: 0.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () {},
                    child: Text(
                      _tags.entity[index]!.name,
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
