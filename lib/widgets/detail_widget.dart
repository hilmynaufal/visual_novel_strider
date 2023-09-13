// ignore_for_file: deprecated_member_use

import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/notification_controller.dart';
import 'package:visual_novel_strider/model/kana_model/detail_result.dart';
import 'package:visual_novel_strider/model/old_socket_model/item.dart';
import 'package:visual_novel_strider/utils/duration_parse.dart';
import 'package:visual_novel_strider/widgets/empty_widget.dart';
import 'package:visual_novel_strider/widgets/route_detail_widget/characters_drawer.dart';
import 'package:visual_novel_strider/widgets/route_detail_widget/characters_route_body.dart';
import 'package:visual_novel_strider/widgets/route_detail_widget/routes_maker_body.dart';
import 'package:visual_novel_strider/widgets/vn_detail_header.dart';

class DetailWidget extends StatefulWidget {
  DetailWidget({Key? key, required this.item}) : super(key: key);

  final DetailResult item;

  final NotificationController _notificationController = Get.find();

  @override
  State<DetailWidget> createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget>
    with TickerProviderStateMixin {
  // final List<Color> _colors = [];

  // void updatePallete() async {
  //   for (int i = 0; i < widget.item.characters!.length; i++) {
  //     if (widget.item.characters![i].image != null) {
  //       final PaletteGenerator generator =
  //           await PaletteGenerator.fromImageProvider(
  //               NetworkImage(widget.item.characters![i].image!),
  //               size: const Size(200, 100));

  //       _colors.add(generator.vibrantColor!.color);
  //     } else {
  //       _colors.add(Colors.black);
  //     }
  //   }
  //   setState(() {});
  // }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    widget._notificationController.hiveRepository
        .getCharactersRoute(widget.item.id);

    return Scaffold(
      backgroundColor: _theme.accentColor,
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              VNDetailHeader(
                image: widget.item.image?.url ?? "",
                title: widget.item.title,
                item: widget.item,
                tabController: _tabController,
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              RoutesMakerBody(item: widget.item),
              CharactersRouteBody(item: widget.item)
            ],
          )),
    );
  }

  String toDuration(String duration) {
    Duration playtime = DurationParsing.parseDuration(duration);
    String s = playtime.inHours.toString() +
        " hours " +
        playtime.inMinutes.toString() +
        " minute";
    return s;
  }
}
