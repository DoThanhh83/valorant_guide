// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valoratn_gui/widgets/playercard_screen/player_card.dart';

class PlayerCardList extends StatelessWidget {
  PlayerCardList({Key? key, required this.snapshot, this.isGrid = true})
      : super(key: key);
  var snapshot;
  bool? isGrid;

  @override
  Widget build(BuildContext context) {
    // Waiting
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(
          // Circular Progress Bar
          child: SizedBox(
              height: 100.h,
              width: 50.w,
              child: const CircularProgressIndicator()));
      // Done
    } else if (snapshot.connectionState == ConnectionState.done) {
      // Done but has error
      if (snapshot.hasError) {
        return const Text('Error');
        // Done and data
      } else if (snapshot.hasData) {
        return Expanded(
          child: isGrid!
              ? GridView.builder(
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  // Gridview padding
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.toList();
                    return PlayerCardCard(
                        playerCard: data[index],
                        index: index,
                        isGrid: isGrid);
                  })
              : ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.toList();
                    return PlayerCardCard(
                        playerCard: data[index],
                        index: index,
                        isGrid: isGrid);
                  },
                ),
        );

        // Empty Data
      } else {
        return const Center(child: Text('Empty data'));
      }

      // For debug
    } else {
      return Text('State: ${snapshot.connectionState}');
    }
  }
}
