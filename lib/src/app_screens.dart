import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/src/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'profile/profile_screen.dart';
import 'rides/create_ride.dart';
import 'rides/rides_screen.dart';

class AppScreens extends StatelessWidget {
  const AppScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 3);

    List<Widget> _buildScreens() {
        return [
         const SearchRides(),
         const CreateRide(),
         const RidesScreen(),
         const ProfileScreen()
        ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
        return [
            PersistentBottomNavBarItem(
                icon: const Icon(CupertinoIcons.search),
                title: ("Поиск"),
                activeColorPrimary: kPrimaryColor,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
                icon: const Icon(CupertinoIcons.plus_circle),
                title: ("Создать"),
                activeColorPrimary: kPrimaryColor,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
             PersistentBottomNavBarItem(
                icon: const Icon(CupertinoIcons.car),
                title: ("Поездки"),
                activeColorPrimary: kPrimaryColor,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
                icon: const Icon(CupertinoIcons.person),
                title: ("Профиль"),
                activeColorPrimary: kPrimaryColor,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
        ];
    }


    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style8, // Choose the nav bar style with this property.
    );
  }
}
