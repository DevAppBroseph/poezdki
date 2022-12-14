import 'package:app_poezdka/bloc/chat/chat_bloc.dart';
import 'package:app_poezdka/bloc/profile/profile_bloc.dart';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/const/images.dart';
import 'package:app_poezdka/src/profile/profile_screen.dart';
import 'package:app_poezdka/src/trips/create_ride.dart';
import 'package:app_poezdka/src/trips/search_trips.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'rides/user_trips_screen.dart';

class AppScreens extends StatefulWidget {
  AppScreens({Key? key}) : super(key: key);

  @override
  State<AppScreens> createState() => _AppScreensState();
}

class _AppScreensState extends State<AppScreens> {
  bool message = false;

  @override
  void initState() {
    BlocProvider.of<ChatBloc>(context).add(StartSocket());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileBloc>(context).add(LoadProfile());
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    List<Widget> _buildScreens() {
      return [
        const SearchRides(),
        const CreateRide(),
        const UserTripsScreen(),
        const ProfileScreen(),
        // const MainDev()
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          inactiveIcon: SvgPicture.asset("$svgPath/search_inactive.svg"),
          icon: SvgPicture.asset('$svgPath/search_active.svg'),
          title: ("Поиск"),
          activeColorPrimary: kPrimaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          inactiveIcon: SvgPicture.asset('$svgPath/add_inactive.svg'),
          icon: SvgPicture.asset('$svgPath/add_active.svg'),
          title: ("Создать"),
          activeColorPrimary: kPrimaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset('$svgPath/car_active.svg'),
          inactiveIcon: SvgPicture.asset('$svgPath/car_inactive.svg'),
          title: ("Поездки"),
          activeColorPrimary: kPrimaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 15),
              SvgPicture.asset(
                '$svgPath/user_active.svg',
              ),
              BlocBuilder<ChatBloc, ChatState>(builder: (context, snapshot) {
                if (snapshot is MessageUnRead) {
                  return SvgPicture.asset(
                    'assets/icon/new_message.svg',
                    color: Colors.red,
                    height: 15,
                  );
                }
                return const SizedBox(width: 15);
              }),
            ],
          ),
          inactiveIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 15),
              SvgPicture.asset("$svgPath/user_inactive.svg",
                  semanticsLabel: 'A red up arrow'),
              BlocBuilder<ChatBloc, ChatState>(builder: (context, snapshot) {
                if (snapshot is MessageUnRead) {
                  return Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/icon/new_message.svg',
                        color: Colors.red,
                        height: 15,
                      ),
                    ],
                  );
                }
                return const SizedBox(width: 15);
              })
            ],
          ),
          title: ("Профиль"),
          activeColorPrimary: kPrimaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        // PersistentBottomNavBarItem(
        //   icon: const Icon(CupertinoIcons.lock_fill),
        //   title: ("Dev"),
        //   activeColorPrimary: kPrimaryColor,
        //   inactiveColorPrimary: CupertinoColors.systemGrey,
        // ),
      ];
    }

    return PersistentTabView(
      context,
      onItemSelected: (value) {
        if (value == _buildScreens().length - 1) {
          BlocProvider.of<ChatBloc>(context).add(CheckNewMessageSupport());
        }
      },
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
        boxShadow: [
          const BoxShadow(
            offset: Offset(0, -4),
            blurRadius: 55,
            spreadRadius: 0,
            color: Color.fromRGBO(26, 42, 97, 0.06),
          ),
        ],
        borderRadius: BorderRadius.circular(0.0),
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
