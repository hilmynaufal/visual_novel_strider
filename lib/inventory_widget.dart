import 'package:backdrop/app_bar.dart';
import 'package:backdrop/scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/hive_repository.dart';

class InventoryWidget extends StatelessWidget {
  const InventoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);

    return BackdropScaffold(
        appBar: BackdropAppBar(
          backgroundColor: _theme.primaryColor,
          title: const Text("Your Inventory"),
        ),
        backLayer: Container(),
        frontLayer: Container(
          color: _theme.accentColor,
          child: GetBuilder<HiveRepository>(
            builder: (_repository) {
              _repository.getItem();
              if (_repository.isReady) {
                return ListView.builder(
                  itemCount: _repository.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        clipBehavior: Clip.hardEdge,
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: _theme.primaryColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            primary: _theme.accentColor,
                            onPrimary: Colors.black),
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 140,
                              width: 100,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                child: (_repository.data![index].imageFlagging!
                                                .sexualAvg +
                                            _repository.data![index]
                                                .imageFlagging!.violenceAvg ==
                                        0)
                                    ? Image.network(
                                        _repository.data![index].image!,
                                        fit: BoxFit.cover,
                                      )
                                    : const Center(
                                        child: Text(
                                          "NSFW",
                                          style: TextStyle(fontSize: 30),
                                        ),
                                      ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    height: 136,
                                    margin: EdgeInsets.only(left: 16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _repository.data![index].title!,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: 8, bottom: 16),
                                              height: 18,
                                              width: 60,
                                              child: OutlinedButton(
                                                  style: OutlinedButton.styleFrom(
                                                      side: const BorderSide(
                                                          color: Colors.blue,
                                                          width: 0.5),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30))),
                                                  onPressed: () {},
                                                  child: const Text(
                                                    "EN",
                                                    style:
                                                        TextStyle(fontSize: 8),
                                                  )),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          _repository.data![index].released!,
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
                                              _repository.data![index].rating
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
                                  ),
                                  LinearProgressIndicator(
                                    backgroundColor: Colors.grey[100],
                                    color: _theme.primaryColor,
                                    minHeight: 4,
                                    value: 0.2,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return Text("no data");
            },
          ),
        ));
  }
}
