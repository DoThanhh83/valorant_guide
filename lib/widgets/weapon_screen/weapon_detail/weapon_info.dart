// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valoratn_gui/models/weapon.dart';

import '../../../constants/app_colors.dart';
import '../../../screens/lineup_list.dart';

class WeaponInfo extends StatelessWidget {
  WeaponInfo({Key? key, required this.weapon}) : super(key: key);

  Weapon weapon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Container(
          decoration: BoxDecoration(
            color: black_second,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 200.h,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // For top padding
              SizedBox(height: 20.h),
              // Weapon Image
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CachedNetworkImage(
                        height: 100.h, imageUrl: weapon.displayIcon!),
                    ...?weapon.skins?.map((e) => GestureDetector(
                        onTap:  () {
                          if (e.levels != null && e.levels!.isNotEmpty) {
                            final lastLevel = e.levels!.last;
                            if (lastLevel.streamedVideo != null) {
                              showDialog(
                                context: context,
                                builder: (context) => PlayVideo(url: lastLevel.streamedVideo!),
                              );
                            }
                          }
                        } ,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CachedNetworkImage(
                              height: 100.h, imageUrl: e.displayIcon ?? e.levels![0].displayIcon!),
                        )))
                  ],
                ),
              ),

              // Weapon name and price section
              Padding(
                padding: EdgeInsets.only(right: 240.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Weapon Name
                    Text(
                      weapon.displayName!,
                      style: TextStyle(
                          color: white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic),
                    ),

                    // For padding
                    SizedBox(
                      height: 5.h,
                    ),
                    // Weapon Cost Section
                    Container(
                        width: 80.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                            color: CupertinoColors.destructiveRed,
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        child: Text(
                          '${weapon.shopData?.cost ?? ""}',
                          style: TextStyle(color: white, fontSize: 17.sp),
                        )),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
