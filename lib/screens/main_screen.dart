import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:valoratn_gui/constants/app_assets.dart';
import 'package:valoratn_gui/network/review_service.dart';
import 'package:valoratn_gui/network/shared_preferences_helper.dart';
import 'package:valoratn_gui/screens/agents_screen.dart';
import 'package:valoratn_gui/screens/maps_screen.dart';
import 'package:valoratn_gui/screens/playercard_screen.dart';
import 'package:valoratn_gui/screens/ranks_screen.dart';
import 'package:valoratn_gui/screens/weapons_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  List<Widget> tabs = [
    const AgentsScreen(),
    const MapsScreen(),
    const WeaponScreen(),
    const RanksScreen(),
    const PlayerCardScreen(),
  ];

  // Review Services
  final ReviewService _reviewService = ReviewService();

  // Assets
  final AppAssets _appAssets = AppAssets();

  @override
  void initState() {
    super.initState();

    // Init sharedprefs
    SharedPreferencesHelper.init();

    // App Review
    Timer(const Duration(seconds: 2), () {
      _reviewService.isSecondTimeOpen().then((secondOpen) {
        if (secondOpen) {
          _reviewService.showRating();
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PersistentTabView(
        context,
        navBarStyle: NavBarStyle.style7,
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
          screens: tabs,
        items: [
          // Agents
          PersistentBottomNavBarItem(
              activeColorPrimary: CupertinoColors.destructiveRed,
              inactiveColorPrimary: CupertinoColors.inactiveGray,
              activeColorSecondary: Colors.white,
              inactiveIcon: Image.asset(
                _appAssets.agents_icon,
                color: CupertinoColors.inactiveGray,
                width: 20.w,
              ),
              icon: Image.asset(
                _appAssets.agents_icon,
                width: 20.w,
              ),
              title: 'Agents'),

          // Maps
          PersistentBottomNavBarItem(
              activeColorPrimary: CupertinoColors.destructiveRed,
              inactiveColorPrimary: CupertinoColors.inactiveGray,
              activeColorSecondary: Colors.white,
              icon: const Icon(Icons.map_rounded),
              title: 'Maps'),

          // Weapons
          PersistentBottomNavBarItem(
              activeColorPrimary: CupertinoColors.destructiveRed,
              inactiveColorPrimary: CupertinoColors.inactiveGray,
              activeColorSecondary: CupertinoColors.white,
              icon: Image.asset(
                _appAssets.weapons_icon,
                width: 20.w,
              ),
              inactiveIcon: Image.asset(
                _appAssets.weapons_icon,
                width: 20.w,
                color: CupertinoColors.inactiveGray,
              ),
              title: 'Weapons'),

          // Ranks
          PersistentBottomNavBarItem(
              activeColorPrimary: CupertinoColors.destructiveRed,
              inactiveColorPrimary: CupertinoColors.inactiveGray,
              activeColorSecondary: Colors.white,
              icon: const Icon(Icons.emoji_events_outlined),
              title: 'Ranks'),

          PersistentBottomNavBarItem(
              activeColorPrimary: CupertinoColors.destructiveRed,
              inactiveColorPrimary: CupertinoColors.inactiveGray,
              activeColorSecondary: Colors.white,
              icon: const Icon(Icons.image),
              title: 'PlayerCard'),
        ],
      ),
    );
  }
}
