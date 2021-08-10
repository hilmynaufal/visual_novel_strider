import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:visual_novel_strider/home_repository.dart';

class HomeWidget extends StatelessWidget {
  HomeWidget({Key? key}) : super(key: key);

  final HomeRepository _repository = Get.put(HomeRepository());

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    _repository.getNewReleased();

    return BackdropScaffold(
        frontLayerBackgroundColor: _theme.accentColor,
        appBar: BackdropAppBar(
          title: Text("Home"),
          backgroundColor: _theme.primaryColor,
        ),
        backLayer: Container(),
        frontLayer: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Obx(
              () {
                if (_repository.result.value.num != 0) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            height: 22,
                            width: 4,
                            color: _theme.primaryColor,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Latest Release",
                            style: TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _repository.result.value.num,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                SizedBox(width: 8),
                                Column(
                                  children: [
                                    Container(
                                      height: 130,
                                      width: 100,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: FadeInImage.memoryNetwork(
                                            placeholder: kTransparentImage,
                                            fit: BoxFit.cover,
                                            image: _repository.result.value
                                                .items[index].image!),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Text(
                                        _repository
                                            .result.value.items[index].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ));
  }
}
