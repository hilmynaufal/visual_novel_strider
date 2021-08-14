import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/shimmer_widget.dart';
import 'package:visual_novel_strider/socket_server.dart';
import 'package:visual_novel_strider/vn_detail.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return GetBuilder<SocketServer>(
        builder: (_controller) => ListView.builder(
            itemCount: _controller.result.value.items.length,
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Get.to(() => VnDetail(
                          i: index,
                        ));
                  },
                  splashColor: _theme.primaryColorLight,
                  child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Hero(
                            tag: 'heroImage',
                            child: ElevatedButton(
                              clipBehavior: Clip.antiAlias,
                              style: ElevatedButton.styleFrom(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.all(0)),
                              onPressed: () {},
                              child: Container(
                                height: 100,
                                width: 70,
                                child: (_controller.result.value.items[index]
                                                .imageFlagging!.sexualAvg +
                                            _controller
                                                .result
                                                .value
                                                .items[index]
                                                .imageFlagging!
                                                .violenceAvg ==
                                        0)
                                    ? FadeInImage.memoryNetwork(
                                        placeholder: kTransparentImage,
                                        image: _controller
                                            .result.value.items[index].image!,
                                        fit: BoxFit.cover,
                                      )
                                    : const Center(
                                        child: Text(
                                          "NSFW",
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _controller.result.value.items[index].title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(right: 8, bottom: 16),
                                      height: 18,
                                      width: 60,
                                      child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                              side: BorderSide(
                                                  color: _theme.primaryColor,
                                                  width: 1),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30))),
                                          onPressed: () {},
                                          child: Text(
                                            "EN",
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                Text(
                                  _controller
                                      .result.value.items[index].released!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 11),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 16,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      _controller
                                          .result.value.items[index].rating!
                                          .toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 11,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                )));
  }
}
