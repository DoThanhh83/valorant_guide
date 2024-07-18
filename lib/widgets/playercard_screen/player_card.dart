// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/app_colors.dart';
import '../../models/playercard.dart';

class PlayerCardCard extends StatefulWidget {
  PlayerCardCard(
      {Key? key,
      required this.playerCard,
      required this.index,
      this.isGrid = true})
      : super(key: key);
  PlayerCard playerCard;
  int index;
  bool? isGrid;

  @override
  State<PlayerCardCard> createState() => _PlayerCardCardState();
}

class _PlayerCardCardState extends State<PlayerCardCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          //Navigator.push(context, MaterialPageRoute(builder: (context) => MapsDetail(mapInfo: map,)));
        },
        child: widget.isGrid!
            ? Padding(
                // Container Size
                padding: const EdgeInsets.all(5),
                child: GestureDetector(
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                widget.playerCard.displayName!,
                                style: TextStyle(
                                    color: black,
                                    fontFamily: 'Valorant',
                                    fontSize: 14.sp),
                              ),
                              Flexible(
                                child: Container(
                                  width:
                                  MediaQuery.of(context).size.width * 0.7,
                                  // height: MediaQuery.of(context).size.height*0.4,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: CachedNetworkImageProvider(
                                            widget.playerCard.largeArt!),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        CachedNetworkImage(
                            width: 60.w,
                            imageUrl: widget.playerCard.displayIcon ??
                                'https://via.placeholder.com/150'),
                        SizedBox(
                          height: 10.h,
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              widget.playerCard.displayName!,
                              style: TextStyle(
                                  color: white,
                                  fontFamily: 'Valorant',
                                  fontSize: 10.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )  : Stack(
          alignment: Alignment.center,
          children: [
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => Dialog(
                        child: Container(
                          width:
                          MediaQuery.of(context).size.width * 0.7,
                          // height: MediaQuery.of(context).size.height*0.4,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: CachedNetworkImageProvider(
                                    widget.playerCard.largeArt!),
                              )),
                        ),
                      ));
                },
                child: Container(
                  width: 1.sw,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: CachedNetworkImageProvider(
                            widget.playerCard.wideArt!),
                      )),
                )),
            Positioned(
              child: Text(
                widget.playerCard.displayName!,
                style: TextStyle(
                    color: white,
                    fontFamily: 'Valorant',
                    fontSize: 10.sp),
              ),
            )
          ],
        ));
  }
}
