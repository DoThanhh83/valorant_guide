import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valoratn_gui/models/playercard.dart';
import 'package:valoratn_gui/network/playercard_client.dart';
import 'package:valoratn_gui/widgets/playercard_screen/playercard_list.dart';

import '../constants/app_colors.dart';

class PlayerCardScreen extends StatefulWidget {
  const PlayerCardScreen({Key? key}) : super(key: key);

  @override
  State<PlayerCardScreen> createState() => _WeaponScreenState();
}

class _WeaponScreenState extends State<PlayerCardScreen> {
  final PlayerCardClient _playerCardClient = PlayerCardClient();
  late Future<Iterable<PlayerCard>> _playercard;
  bool isGrid = true;

  @override
  void initState() {
    _playercard = _playerCardClient.getPlayerCard();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50.h, left: 13.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const Center(
                  child: Text(
                    'PlayerCard',
                    style: TextStyle(
                        color: white, fontSize: 30, fontFamily: 'Valorant'),
                    textAlign: TextAlign.start,
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      setState(() {
                        isGrid = !isGrid;
                      });
                    },
                    icon: isGrid
                        ? const Icon(
                            Icons.list,
                            color: white,
                          )
                        : const Icon(
                            Icons.grid_on_outlined,
                            color: white,
                          ))
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          FutureBuilder<Iterable<PlayerCard>>(
            future: _playercard,
            builder: (
              BuildContext context,
              AsyncSnapshot<Iterable<PlayerCard>> snapshot,
            ) {
              return PlayerCardList(snapshot: snapshot, isGrid: isGrid);
            },
          ),
        ],
      ),
    );
  }
}
