import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/item_widget.dart';
import 'package:visual_novel_strider/screens_widget.dart';
import 'package:visual_novel_strider/socket_server.dart';
import 'package:readmore/readmore.dart';

class VnDetail extends StatelessWidget {
  VnDetail({Key? key, required this.i}) : super(key: key);

  int i;

  @override
  Widget build(BuildContext context) {
    final SocketServer _controller = Get.find();
    final ThemeData _theme = Theme.of(context);

    return (Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        backwardsCompatibility: true,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Detail",
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: _controller.isReady
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          width: 130,
                          height: 170,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              _controller.result!.value.items[i].image!,
                              fit: BoxFit.cover,
                              scale: 2,
                            ),
                          )),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _controller.result!.value.items[i].title,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 20,
                                      color: _theme.primaryColor,
                                    ),
                                    Text(
                                      _controller.result!.value.items[i].rating!
                                          .toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "#${_controller.result!.value.items[i].popularity}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text("Popularity")
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 20,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      _controller.result!.value.items[i].rating!
                                          .toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(height: 1, color: Colors.grey.shade200),
                  const SizedBox(height: 8),
                  const Text("Description",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(height: 8),
                  ReadMoreText(
                    _controller.result!.value.items[i].description!,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 16),
                  Container(height: 1, color: Colors.grey.shade200),
                  const SizedBox(height: 8),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          const Text("Avaibility",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                          ButtonBarSuper(
                            alignment: WrapSuperAlignment.center,
                            wrapType: WrapType.balanced,
                            wrapFit: WrapFit.min,
                            spacing: 1,
                            lineSpacing: 8,
                            children: [
                              SizedBox(
                                height: 18,
                                child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                            color: _theme.primaryColor,
                                            width: 0.5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    onPressed: () {},
                                    child: Text(
                                      "Branching Plot",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: _theme.primaryColor),
                                    )),
                              ),
                              SizedBox(
                                height: 18,
                                child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                            color: _theme.primaryColor,
                                            width: 0.5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    onPressed: () {},
                                    child: Text(
                                      "Linear Plot",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: _theme.primaryColor),
                                    )),
                              ),
                              SizedBox(
                                height: 18,
                                child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                            color: _theme.primaryColor,
                                            width: 0.5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    onPressed: () {},
                                    child: Text(
                                      "Kinetic Novel",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: _theme.primaryColor),
                                    )),
                              ),
                              SizedBox(
                                height: 18,
                                child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                            color: _theme.primaryColor,
                                            width: 0.5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    onPressed: () {},
                                    child: Text(
                                      "More Then Seven Endings",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: _theme.primaryColor),
                                    )),
                              ),
                              SizedBox(
                                height: 18,
                                child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                            color: _theme.primaryColor,
                                            width: 0.5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    onPressed: () {},
                                    child: Text(
                                      "Branching Plot",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: _theme.primaryColor),
                                    )),
                              ),
                              SizedBox(
                                height: 18,
                                child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: Colors.blue, width: 0.5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    onPressed: () {},
                                    child: const Text(
                                      "Error",
                                      style: TextStyle(fontSize: 12),
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    padding: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _theme.primaryColorLight.withOpacity(0.1),
                      border: Border.all(
                          color: const Color.fromARGB(255, 51, 204, 255),
                          width: 1),
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ScreensWidget(
                      screenshot: _controller.result!.value.items[i].screens),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            )
          : const LinearProgressIndicator(),
    ));
  }
}
