import 'package:backdrop/scaffold.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/hive_repository.dart';

class InventoryWidget extends StatelessWidget {
  InventoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
        backLayer: Container(),
        frontLayer: Container(
          child: GetBuilder<HiveRepository>(
            builder: (_repository) {
              _repository.getItem();
              if (_repository.isReady) {
                return ListView.builder(
                  itemCount: _repository.data!.length,
                  itemBuilder: (context, index) {
                    return Text(_repository.data![index].title!);
                  },
                );
              }
              return Text("no data");
            },
          ),
        ));
  }
}
