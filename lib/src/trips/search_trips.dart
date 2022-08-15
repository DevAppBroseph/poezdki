// ignore_for_file: unused_field

import 'package:app_poezdka/bloc/trips_driver/trips_bloc.dart';
import 'package:app_poezdka/bloc/trips_driver/trips_builder.dart';
import 'package:app_poezdka/bloc/trips_passenger/trips_p_builder.dart';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/model/filter_model.dart';
import 'package:app_poezdka/model/trip_model.dart';

import 'package:app_poezdka/src/auth/signin.dart';
import 'package:app_poezdka/src/trips/components/pick_city.dart';
import 'package:app_poezdka/src/rides/components/waypoint.dart';
import 'package:app_poezdka/src/rides/components/waypoints.dart';
import 'package:app_poezdka/src/trips/components/search_trip_filter.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../widget/text_field/custom_text_field.dart';

class SearchRides extends StatefulWidget {
  final bool? isAuthorized;
  const SearchRides({Key? key, this.isAuthorized}) : super(key: key);

  @override
  State<SearchRides> createState() => _SearchRidesState();
}

class _SearchRidesState extends State<SearchRides>
    with SingleTickerProviderStateMixin {
  final btmSheet = BottomSheetCallAwait();
  int searchPageIndex = 1;
  Departure? from;
  Departure? to;
  TabController? _tabController;

  final TextEditingController startWay = TextEditingController();
  final TextEditingController endWay = TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  FilterModel filter = FilterModel(
      isPackageTransfer: false,
      isTwoBackSeat: false,
      isBagadgeTransfer: false,
      isChildSeat: false,
      isConditioner: false,
      isSmoking: false,
      isPetTransfer: false,
      gender: null);

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Future _refresh() async {}

  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
      title: "Поиск поездок",
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
              onPressed: () => applyFilters(),
              icon: const Icon(MaterialCommunityIcons.filter_outline)),
        )
      ],
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: kPrimaryWhite,
        child: NestedScrollView(
          headerSliverBuilder: (context, bool inner) {
            return [
              SliverAppBar(
                bottom: _bottomFilter(),
              )
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              CustomScrollView(
                slivers: [
                  CupertinoSliverRefreshControl(
                    onRefresh: () => fetchTrips(context, page: searchPageIndex),
                  ),
                  SliverToBoxAdapter(
                    child: const TripsBuilder(),
                  )
                ],
              ),
              CustomScrollView(
                slivers: [
                  CupertinoSliverRefreshControl(
                    onRefresh: () => fetchTrips(context, page: searchPageIndex),
                  ),
                  SliverToBoxAdapter(
                    child: RefreshIndicator(
                      triggerMode: RefreshIndicatorTriggerMode.anywhere,
                      onRefresh: () =>
                          fetchTrips(context, page: searchPageIndex),
                      child: const TripsPassengerBuilder(),
                    ),
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
                            padding: const EdgeInsets.only(right: 0, top: 5),
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
                            ),
                          )
                        : const SizedBox(),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        'assets/img/gps.svg',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                const WayPointField(
                  type: WaypointType.empty,
                  textField: SizedBox(
                    height: 10,
                  ),
                ),
                WayPointField(
                    type: WaypointType.end,
                    textField: KFormField(
                      onTap: () => pickDestinition(
                        context,
                        endWay,
                        to,
                        "Куда едем?",
                      ),
                      readOnly: true,
                      hintText: "Куда",
                      textEditingController: endWay,
                      suffix: endWay.text.isNotEmpty
                          ? IconButton(
                              padding: const EdgeInsets.only(right: 0, top: 5),
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
                              ),
                            )
                          : const SizedBox(),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          'assets/img/gps.svg',
                          width: 20,
                          height: 20,
                        ),
                      ),
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
                filter.isPackageTransfer = !filter.isPackageTransfer;
                fetchTrips(context, page: searchPageIndex);
              }),
              leading: Icon(
                filter.isPackageTransfer
                    ? MaterialIcons.radio_button_checked
                    : MaterialIcons.radio_button_unchecked,
                color: filter.isPackageTransfer ? kPrimaryColor : null,
              ),
              title: const Text("Передать посылку"),
            ),
          )
        ],
      ),
      preferredSize: const Size(200, 308),
    );
  }

  void pickDestinition(context, TextEditingController contoller,
      Departure? city, String title) async {
    final Departure? destinition = await btmSheet.wait(context,
        useRootNavigator: true,
        child: PickCity(
          title: title,
        ));
    if (destinition != null) {
      setState(() {
        contoller.text = destinition.name!;
        city = destinition;
      });
      print(to);
      fetchTrips(context, page: searchPageIndex);
    }
  }

  Future<void> fetchTrips(
    context, {
    int? page,
  }) async {
    final tripsBloc = BlocProvider.of<TripsBloc>(context);
    tripsBloc.add(
      LoadAllTripsList(
        page: page,
        departure: from,
        destination: to,
        animals: filter.isPetTransfer,
        package: filter.isPackageTransfer,
        baggage: filter.isBagadgeTransfer,
        babyChair: filter.isChildSeat,
        smoke: filter.isSmoking,
        twoPlacesInBehind: filter.isTwoBackSeat,
        conditioner: filter.isConditioner,
        gender: filter.gender?.apiTitle,
      ),
    );
  }

  void applyFilters() async {
    final FilterModel? newFilter = await btmSheet.wait(context,
        child: SearchTripBottomSheet(
          initFilter: filter,
        ));
    if (newFilter != null) {
      setState(() {
        filter = newFilter;
        searchPageIndex = 1;
        fetchTrips(context, page: searchPageIndex);
      });
    }
  }
}
