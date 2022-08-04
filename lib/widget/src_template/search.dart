import 'package:app_poezdka/bloc/trips/trips_builder.dart';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/database/database.dart';
import 'package:app_poezdka/database/table/ride.dart';
import 'package:app_poezdka/src/auth/signin.dart';
import 'package:app_poezdka/src/rides/components/pick_city.dart';
import 'package:app_poezdka/src/rides/components/ride_tile.dart';
import 'package:app_poezdka/src/rides/components/waypoint.dart';
import 'package:app_poezdka/src/rides/components/waypoints.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../model/city_model.dart';
import '../text_field/custom_text_field.dart';
import '../../src/rides/components/filter_sheet.dart';

class SearchRides extends StatefulWidget {
  final bool? isAuthorized;
  const SearchRides({Key? key, this.isAuthorized}) : super(key: key);

  @override
  State<SearchRides> createState() => _SearchRidesState();
}

class _SearchRidesState extends State<SearchRides>
    with SingleTickerProviderStateMixin {
  final btmSheet = BottomSheetCallAwait();
  City? from;
  City? to;
  TabController? _tabController;

  final TextEditingController startWay = TextEditingController();
  final TextEditingController endWay = TextEditingController();

  bool _isPackageTransfer = false;
  final bool _isTwoBackSeat = false;
  final bool _isBagadgeTransfer = false;
  final bool _isChildSeat = false;
  final bool _isCondition = false;
  final bool _isSmoking = false;
  final bool _isPetTransfer = false;
  final bool _isPickUpFromHome = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return KScaffoldScreen(
      title: "Поиск поездок",
      actions: [
        IconButton(
            onPressed: () => BottomSheetCall().show(context,
                topRadius: const Radius.circular(50),
                useRootNavigator: true,
                child: const FilterSheet()),
            icon: const Icon(MaterialCommunityIcons.filter_outline))
      ],
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: kPrimaryWhite,
        child: NestedScrollView(
          headerSliverBuilder: (context, bool inner) {
            return [
              SliverAppBar(
                // collapsedHeight: 80,
                // expandedHeight: 100.0,
                //forceElevated: innerBoxIsScrolled,
                //floating: true,
                bottom: _bottomFilter(),
              )
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: const[
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: TripsBuilder(),
                  )
                ],
              ),
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Text("Rides"),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: widget.isAuthorized != null &&
              widget.isAuthorized == false
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: FullWidthElevButton(
                title: "Авторизироваться",
                onPressed: () => pushNewScreen(context,
                    withNavBar: false, screen: const SignInScreen()),
              ),
            )
          : null,
    );
  }

  // Widget filteredRides(
  //     RideDao rideDb, String startWay, String endWay, bool _isPackageTransfer) {
  //   return StreamBuilder<List<RideData>>(
  //       stream: rideDb.getFilteredRides(
  //           from: startWay, to: endWay, isPackageTransfer: _isPackageTransfer),
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.active) {
  //           final rides = snapshot.data ?? [];
  //           return rides.isNotEmpty
  //               ? ListView.builder(
  //                   physics: const NeverScrollableScrollPhysics(),
  //                   shrinkWrap: true,
  //                   itemCount: rides.length,
  //                   itemBuilder: (context, int index) => RideTile(
  //                         tripData: rides[index],
  //                       ))
  //               : const Center(
  //                   child: Text("Поездок по вашему фильтру не найдено"),
  //                 );
  //         }
  //         return const Center(
  //           child: Text("Поездок еще нет"),
  //         );
  //       });
  // }

  Widget allRides(RideDao rideDb) {
    return StreamBuilder<List<RideData>>(
        stream: rideDb.getAllRidesAsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final rides = snapshot.data ?? [];
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: rides.length,
                itemBuilder: (context, int index) => Container());
          }
          return const Center(
            child: Text("Поездок еще нет"),
          );
        });
  }

  PreferredSize _bottomFilter() {
    return PreferredSize(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              onTap: (value) => setState(() {}),
              controller: _tabController,
              splashBorderRadius: BorderRadius.circular(25),
              // give the indicator a decoration (color and border radius)
              indicator: _tabController!.index == 0
                  ? const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                      ),
                      color: kPrimaryColor,
                    )
                  : const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                      color: kPrimaryColor,
                    ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: const [
                // first tab [you can add an icon using the icon property]
                Tab(
                  text: 'Я пассажир',
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                  text: 'Я водитель',
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Column(
                children: [
                  WayPointField(
                      type: WaypointType.start,
                      textField: KFormField(
                        readOnly: true,
                        onTap: () => pickDestinition(
                            context, startWay, from, "Откуда едем?"),
                        hintText: "Откуда",
                        textEditingController: startWay,
                        suffix: startWay.text.isNotEmpty
                            ? IconButton(
                                padding:
                                    const EdgeInsets.only(right: 0, top: 5),
                                alignment: Alignment.centerRight,
                                onPressed: () {
                                  setState(() {
                                    from == null;
                                    startWay.clear();
                                  });
                                },
                                icon: const Icon(
                                  CupertinoIcons.clear_circled,
                                  size: 18,
                                  color: kPrimaryDarkGrey,
                                ))
                            : const SizedBox(),
                        suffixIcon: Image.asset('assets/img/gps.png'),
                        onChanged: (value) {
                          setState(() {});
                        },
                      )),
                  const WayPointField(
                      type: WaypointType.empty,
                      textField: SizedBox(
                        height: 10,
                      )),
                  WayPointField(
                      type: WaypointType.end,
                      textField: KFormField(
                        onTap: () =>
                            pickDestinition(context, endWay, to, "Куда едем?"),
                        readOnly: true,
                        hintText: "Куда",
                        textEditingController: endWay,
                        suffix: endWay.text.isNotEmpty
                            ? IconButton(
                                padding:
                                    const EdgeInsets.only(right: 0, top: 5),
                                alignment: Alignment.centerRight,
                                onPressed: () {
                                  setState(() {
                                    to == null;
                                    endWay.clear();
                                  });
                                },
                                icon: const Icon(
                                  CupertinoIcons.clear_circled,
                                  size: 18,
                                  color: kPrimaryDarkGrey,
                                ))
                            : const SizedBox(),
                        suffixIcon: Image.asset('assets/img/gps.png'),
                        onChanged: (value) {
                          setState(() {});
                        },
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: ListTile(
                onTap: () => setState(() {
                  _isPackageTransfer = !_isPackageTransfer;
                }),
                leading: Icon(
                  _isPackageTransfer
                      ? MaterialIcons.radio_button_checked
                      : MaterialIcons.radio_button_unchecked,
                  color: _isPackageTransfer ? kPrimaryColor : null,
                ),
                title: const Text("Передать посылку"),
              ),
            )
          ],
        ),
        preferredSize: const Size(200, 308));
  }

  void pickDestinition(context, TextEditingController contoller, City? city,
      String title) async {
    final City? destinition = await btmSheet.wait(context,
        useRootNavigator: true,
        child: PickCity(
          title: title,
        ));
    if (destinition != null) {
      setState(() {
        contoller.text = destinition.name!;
        city = destinition;
      });
    }
  }
}
