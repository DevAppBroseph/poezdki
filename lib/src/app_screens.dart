import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/src/aaa_dev/main_dev.dart';
import 'package:app_poezdka/src/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        const ProfileScreen(),
        const MainDev()
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          inactiveIcon: Image.asset('assets/img/search_normal.png'), 
          icon: Image.asset('assets/img/search_active.png'),
          title: ("Поиск"),
          activeColorPrimary: kPrimaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          inactiveIcon: Image.asset('assets/img/add_circle.png'),
          icon: SvgPicture.asset('assets/img/add_circle_active.svg'),
          title: ("Создать"),
          activeColorPrimary: kPrimaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset('assets/img/car_active.png'),
          inactiveIcon: Image.asset('assets/img/car.png'),
          title: ("Поездки"),
          activeColorPrimary: kPrimaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset('assets/img/user.png'),
          inactiveIcon: SvgPicture.asset("assets/img/user.svg",
              semanticsLabel: 'A red up arrow'),
          title: ("Профиль"),
          activeColorPrimary: kPrimaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.lock_fill),
          title: ("Dev"),
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
