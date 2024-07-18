import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:valoratn_gui/models/lineup.dart';
import 'package:valoratn_gui/network/api_client.dart';

import '../constants/app_colors.dart';
import '../models/agent.dart';
import '../models/map.dart';
import '../network/maps_client.dart';

class LineupList extends StatefulWidget {
  final List<Abilities>? agentAbilities;
  final Agent? agent;

  const LineupList({Key? key, this.agentAbilities, this.agent})
      : super(key: key);

  @override
  State<LineupList> createState() => _LineupListState();
}

class _LineupListState extends State<LineupList> {
  MapsClient mapsClient = MapsClient();
  List<LineUp>? data = [];
  List<Media>? datadetail = [];
  List<Media>? tempdatadetail = [];
  String agentName = '';
  String abilityName = 'all';
  String mapName = 'Ascent';
  List<String> mapNames = ['Ascent', 'Bind', 'Fracture', 'Split'];
  late Future<Iterable<Maps>> maps;
  bool isExpan = false;

  int selectedSideIndex = 0;

  // Agent Filter List
  var sideFillter = [
    // 'all',
    'attack',
    'defense',
  ];

  int selectedFilterIndex = 0;

  // Agent Filter List
  var siteFillter = ['All', 'A', 'B', 'C'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      agentName = widget.agent!.displayName!;
    });
    loadMap();
    loadData();
  }

  Future<void> loadMap() async {
    Dio dio = Dio();
    Response response = await dio.get("${ApiClient.baseUrls}v1/maps");

    List parsedList = response.data['data'];
    List<Maps> mapsList =
        parsedList.map((data) => Maps.fromJson(data)).toList();
    mapNames = mapsList
        .where(
            (map) => map.displayName != null && map.tacticalDescription != null)
        .map((map) => map.displayName)
        .cast<String>()
        .toList();

    print(mapNames);
  }

  Future<void> loadData() async {
    Dio dio = Dio();
    try {
      var agentnameConvtr = agentName;
      if (agentName == "KAY/O") {
        agentnameConvtr = "KAY%2FO";
      }
      var response = await dio.get(
          'https://api.lineups.fun/get/media/$mapName/$agentnameConvtr/$abilityName');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.data);
        setState(() {
          if (jsonData['media'] != null) {
            datadetail = (jsonData['media'] as List)
                .map((item) => Media.fromJson(item))
                .toList();
            tempdatadetail = datadetail;
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi khi gọi API: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
          padding: EdgeInsets.only(top: 50.h, left: 13.w),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back, color: white)),
              const Text(
                'Lineup List',
                style: TextStyle(
                    color: white, fontSize: 30, fontFamily: 'Valorant'),
                textAlign: TextAlign.start,
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    setState(() {
                      isExpan = !isExpan;
                    });
                  },
                  icon: const Icon(Icons.search, color: white)),
            ],
          ),
        ),
        isExpan
            ? Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Map',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Valorant'),
                          ),
                          DropdownButton<String>(
                            value: mapName,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontFamily: 'Valorant'),
                            underline: Container(
                              height: 0,
                              color: Colors.white,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                mapName = newValue!;
                                loadData();
                                selectedSideIndex = 0;
                                selectedFilterIndex = 0;
                              });
                            },
                            items: mapNames
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                                onTap: () {
                                  setState(() {
                                    mapName = value;
                                    loadData();
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: siteFillter.length,
                        itemBuilder: (context, index) {
                          return LayoutBuilder(builder: (context, constraints) {
                            return Padding(
                              padding: EdgeInsets.all(Platform.isAndroid
                                  ? 6.w
                                  :
                                  // iPhone 7 - 38 and iPhone 5S - SE 1. Gen - 32
                                  constraints.maxHeight.round() == 38 ||
                                          constraints.maxHeight.round() == 32
                                      ? 7.h
                                      :
                                      // Others
                                      8.w),
                              // Gesture detector for index update
                              child: GestureDetector(
                                onTap: () {
                                  if (siteFillter[index].toLowerCase() ==
                                      'all') {
                                    setState(() {
                                      // datadetail = datadetail.where((element) => element.position);
                                      loadData();
                                      selectedFilterIndex = index;
                                    });
                                  } else {
                                    setState(() {
                                      // tempdatadetail = datadetail!.where((element) => element.side == siteFillter[index] && element.position == sideFillter[selectedFilterIndex]).toList();
                                      tempdatadetail = datadetail!
                                          .where((element) =>
                                              element.position ==
                                              siteFillter[index])
                                          .toList();
                                      selectedFilterIndex = index;
                                    });
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: selectedFilterIndex == index
                                          ? CupertinoColors.systemRed
                                          : CupertinoColors.white),
                                  width: 100.w,
                                  alignment: Alignment.center,
                                  child: Text(
                                    siteFillter[index],
                                    style: TextStyle(
                                        color: selectedFilterIndex == index
                                            ? white
                                            : black,
                                        fontFamily: 'Valorant',
                                        fontSize: 10.5.sp),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ...sideFillter.map(
                            (e) => Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  if (sideFillter[sideFillter.indexOf(e)]
                                          .toLowerCase() ==
                                      'all') {
                                    setState(() {
                                      tempdatadetail = datadetail;
                                      selectedSideIndex =
                                          sideFillter.indexOf(e);
                                    });
                                  } else {
                                    setState(() {
                                      tempdatadetail = datadetail!
                                          .where((element) =>
                                              element.side ==
                                              sideFillter[
                                                  sideFillter.indexOf(e)])
                                          .toList();
                                      selectedSideIndex =
                                          sideFillter.indexOf(e);
                                    });
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: selectedSideIndex ==
                                              sideFillter.indexOf(e)
                                          ? CupertinoColors.systemRed
                                          : CupertinoColors.white),
                                  width: 100.w,
                                  alignment: Alignment.center,
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                        color: selectedSideIndex ==
                                                sideFillter.indexOf(e)
                                            ? white
                                            : black,
                                        fontFamily: 'Valorant',
                                        fontSize: 10.5.sp),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            : Container(),
        datadetail!.isEmpty
            ? Center(
                child: Column(
                  children: [
                    CachedNetworkImage(
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        imageUrl: widget.agent!.fullPortraitV2!),
                    const Text("Chưa có rồi ! Quay lại sau nhé",
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Valorant')),
                  ],
                ),
              )
            :
            // Column(
            //   children: tempdatadetail!
            //       .map((e) =>
            //       GestureDetector(
            //         onTap: () {
            //           // Navigator.push(context, MaterialPageRoute(builder: (context) =>PlayVideo(url: e.source!) ,));
            //           showDialog(
            //             context: context,
            //             builder: (context) => PlayVideo(url: e.source!),
            //           );
            //         },
            //         child: Container(
            //           padding: const EdgeInsets.all(15.0),
            //           margin: const EdgeInsets.all(15.0), // Add padding
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10.0),
            //             border: Border.all(
            //               color: Colors.white, // Border color
            //               width: 1.0, // Border width
            //             ),
            //           ),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: <Widget>[
            //               // Image at the top
            //               Image.network(
            //                 e.thumbnails![1].source!,
            //                 errorBuilder: (BuildContext context,
            //                     Object error, StackTrace? stackTrace) {
            //                   // Khi tải ảnh từ thumbnails[2] thất bại, chuyển sang thumbnails[0]
            //                   return Image.network(
            //                       e.thumbnails![0].source!);
            //                 },
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(
            //                     vertical: 5.0),
            //                 child: Column(
            //                   children: [
            //                     Text(
            //                       '${e.title}',
            //                       style: const TextStyle(
            //                           color: Colors.white),
            //                     ),
            //                     Text(
            //                       '${e.position} site',
            //                       style: const TextStyle(
            //                           color: Colors.white),
            //                     ),
            //                     Text(
            //                       '${e.side}'.toUpperCase(),
            //                       style: const TextStyle(
            //                           color: Colors.white),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ))
            //       .toList(),
            // ),
            Expanded(
                child: ListView.builder(
                  itemCount: tempdatadetail!.length,
                  itemBuilder: (context, index) {
                    var e = tempdatadetail![index];
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) =>PlayVideo(url: e.source!) ,));
                        showDialog(
                          context: context,
                          builder: (context) => PlayVideo(url: e.source!),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        margin: const EdgeInsets.all(15.0), // Add padding
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.white, // Border color
                            width: 1.0, // Border width
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // Image at the top
                            Image.network(
                              e.thumbnails![1].source!,
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                // Khi tải ảnh từ thumbnails[2] thất bại, chuyển sang thumbnails[0]
                                return Image.network(e.thumbnails![0].source!);
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Column(
                                children: [
                                  Text(
                                    '${e.title}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    '${e.position} site',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    '${e.side}'.toUpperCase(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
      ]),
    ));
  }
}

class PlayVideo extends StatefulWidget {
  final String url;

  const PlayVideo({Key? key, required this.url}) : super(key: key);

  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  late VlcPlayerController? _videoPlayerController;

  void _playVideo(String url) {
    _videoPlayerController = VlcPlayerController.network(
      url,
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _playVideo(widget.url);
  }

  @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VlcPlayer(
            controller: _videoPlayerController!,
            aspectRatio: 16 / 9,
            placeholder: const Center(child: CircularProgressIndicator()),
          ),
          // IconButton(onPressed: (){z
          //       setState(() {});
          // }, icon: Icon(Icons.replay)),
        ],
      ),
    );
  }
}
