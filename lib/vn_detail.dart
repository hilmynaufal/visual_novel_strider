import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/socket_server.dart';

class VnDetail extends StatelessWidget {
  VnDetail({Key? key, required this.i}) : super(key: key);

  int i;

  @override
  Widget build(BuildContext context) {
    final SocketServer _controller = Get.find();

    return (Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _controller.isReady
              ? SizedBox(
                  height: 230,
                  child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                _controller
                                    .result!.value.items[i].screens![0].image!,
                              )))),
                )
              : const LinearProgressIndicator(),
        ],
      ),
    ));
  }
}
