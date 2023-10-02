import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/kana_model/detail_result.dart';
import '../utils/length_convert.dart';

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
    // log(widget.item.developers.toString());
    final theme = Theme.of(context);
    return SliverAppBar(
      backgroundColor: theme.primaryColorLight,
      elevation: 0,
      foregroundColor: Colors.black,
      pinned: true,
      // bottom: PreferredSize(
      //     preferredSize: Size.fromHeight(100),
      //     child: Container(
      //       height: 100,
      //       color: Colors.red,
      //     )),
      expandedHeight: widget.tabController != null ? 330 : 300,

      bottom: widget.tabController != null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: Container(
                color: theme.primaryColorLight,
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
          height: 240,
          margin: const EdgeInsets.only(top: 80),
          child: Column(
            children: [
              SizedBox(
                height: 240,
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
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
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.black.withOpacity(0.7),
                              Colors.black
                            ],
                                stops: const [
                              0.0,
                              0.8,
                              1.0
                            ])),
                      ),
                    ),
                    Positioned.fill(
                        child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {},
                                  clipBehavior: Clip.antiAlias,
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    elevation: 4,
                                    padding: const EdgeInsets.all(0),
                                  ),
                                  child: SizedBox(
                                    width: 110,
                                    height: 150,
                                    child: FancyShimmerImage(
                                      imageUrl: widget.image,
                                      boxFit: BoxFit.cover,
                                      // alignment: Alignment.topCenter,
                                    ),
                                  )),
                              Expanded(
                                child: Column(
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
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                        widget.item.alttitle ??
                                            widget.item.title,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white)),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "by ",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          widget.item.developers.isEmpty
                                              ? "No Developer"
                                              : widget.item.developers[0].name,
                                          // _charactersRepository
                                          //     .releaseResult
                                          //     .value
                                          //     .items![0]
                                          //     .producers![0]
                                          //     .name,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.star_circle,
                                    size: 16,
                                    color: theme.primaryColorLight,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    widget.item.rating != null
                                        ? widget.item.rating.toString()
                                        : "No Rating",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: theme.primaryColorLight),
                                  ),
                                  Text(
                                    "/100",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 12,
                                        color: theme.primaryColorLight),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Container(
                                height: 16,
                                color: Colors.grey,
                                width: 1,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.clock_solid,
                                    size: 12,
                                    color: theme.primaryColorLight,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    widget.item.length != null
                                        ? LengthConvert.intLengthtoString(
                                            widget.item.length!)
                                        : "No Record",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: theme.primaryColorLight),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Container(
                                height: 12,
                                color: Colors.grey,
                                width: 1,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.swap_vert_circle_outlined,
                                    size: 16,
                                    color: theme.primaryColorLight,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    "#${widget.item.popularity!.round()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: theme.primaryColorLight),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
