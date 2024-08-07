// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valoratn_gui/constants/app_colors.dart';

import '../../models/map.dart';

class MapsCard extends StatelessWidget {
  MapsCard({Key? key, required this.map}) : super(key: key);
  Maps map;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Navigator.push(context, MaterialPageRoute(builder: (context) => MapsDetail(mapInfo: map,)));
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          TextButton(
            onPressed: map.displayName != "The Range" ? (){
              showDialog(context: context,
                  builder: (_)=> Dialog(
                    child: Container(
                    width: MediaQuery.of(context).size.width*0.7,
                    height: MediaQuery.of(context).size.height*0.4,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(map.displayIcon!),
                        )
                    ),
                  ),)) ;
            } : null,
            child: Container(
              width: 1.sw,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(map.listViewIcon!),
                  )),
            ),
          ),
          Positioned(
            child: Text(
              map.displayName!,
              style: TextStyle(
                  color: white, fontFamily: 'Valorant', fontSize: 20.sp),
            ),
          )
        ],
      ),
    );
  }
}
