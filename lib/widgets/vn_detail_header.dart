import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visual_novel_strider/controller&repository/detail_repository.dart';

import '../model/kana_model/detail_result.dart';
import '../utils/datetime_parse.dart';

class VNDetailHeader extends StatefulWidget {
  const VNDetailHeader({
    Key? key,
    required this.image,
    required this.title,
    required this.item,
    required this.tabController,
  }) : super(key: key);

  final String image, title;
  final DetailResult item;
  final TabController? tabController;

  @override
  State<VNDetailHeader> createState() => _VNDetailHeaderState();
}

class _VNDetailHeaderState extends State<VNDetailHeader> {
  var height = 0.0;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return SliverAppBar(
      backgroundColor: _theme.accentColor,
      elevation: 0,
      foregroundColor: Colors.black,
      pinned: true,
      // bottom: PreferredSize(
      //     preferredSize: Size.fromHeight(100),
      //     child: Container(
      //       height: 100,
      //       color: Colors.red,
      //     )),
      expandedHeight: widget.tabController != null ? 400 : 380,

      bottom: widget.tabController != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: Container(
                color: _theme.accentColor,
                child: TabBar(
                    controller: widget.tabController,
                    indicatorColor: Colors.grey[200],
                    tabs: const [
                      Tab(
                        child: Text("Characters"),
                      ),
                      Tab(
                        child: Text("Routes"),
                      ),
                    ]),
              ),
            )
          : null,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          height: 300,
          margin: EdgeInsets.only(top: 60),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      child: (widget.item.image!.sexual +
                                  widget.item.image!.violence <=
                              2)
                          ? FancyShimmerImage(
                              imageUrl: widget.image,
                              boxFit: BoxFit.cover,
                            )
                          : const Center(
                              child: Text(
                                "NSFW",
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: 140,
                      child: (widget.item.image!.sexual +
                                  widget.item.image!.violence <=
                              2)
                          ? FancyShimmerImage(
                              imageUrl: widget.image,
                              boxFit: BoxFit.cover,
                            )
                          : const Center(
                              child: Text(
                                "NSFW",
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 16),
                child: Text(
                  DateTimeParse.parseDateTime(widget.item.released!),
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade900,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w100),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    widget.title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(widget.item.alttitle ?? widget.item.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 8, fontWeight: FontWeight.w300)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("by "),
                      Text(
                        "TODO",
                        // _charactersRepository
                        //     .releaseResult
                        //     .value
                        //     .items![0]
                        //     .producers![0]
                        //     .name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
