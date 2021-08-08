import 'package:backdrop/app_bar.dart';
import 'package:backdrop/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/hive_repository.dart';

class InventoryWidget extends StatelessWidget {
  InventoryWidget({Key? key}) : super(key: key);

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
          child: GetBuilder<HiveRepository>(
            builder: (_repository) {
              _repository.getItem();
              if (_repository.isReady) {
                return ListView.builder(
                  itemCount: _repository.data!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      splashColor: Colors.blue[200],
                      child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 11, horizontal: 16),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 16),
                                height: 100,
                                width: 70,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: (_repository.data![index]
                                                  .imageFlagging!.sexualAvg +
                                              _repository.data![index]
                                                  .imageFlagging!.violenceAvg ==
                                          0)
                                      ? Image.network(
                                          _repository.data![index].image!,
                                          fit: BoxFit.cover,
                                        )
                                      : Text(
                                          "NSFW",
                                          style: TextStyle(fontSize: 30),
                                        ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          margin: EdgeInsets.only(
                                              right: 8, bottom: 16),
                                          height: 18,
                                          width: 60,
                                          child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                  side: const BorderSide(
                                                      color: Colors.blue,
                                                      width: 0.5),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30))),
                                              onPressed: () {},
                                              child: const Text(
                                                "EN",
                                                style: TextStyle(fontSize: 8),
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
                              )
                            ],
                          )),
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
