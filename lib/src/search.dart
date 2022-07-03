import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/database/database.dart';
import 'package:app_poezdka/database/table/ride.dart';
import 'package:app_poezdka/src/rides/components/ride_tile.dart';
import 'package:app_poezdka/src/rides/components/waypoint.dart';
import 'package:app_poezdka/src/rides/components/waypoints.dart';
import 'package:app_poezdka/src/rides/ride_details.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

import '../widget/text_field/custom_text_field.dart';
import 'rides/components/filter_sheet.dart';

class SearchRides extends StatefulWidget {
  const SearchRides({Key? key}) : super(key: key);

  @override
  State<SearchRides> createState() => _SearchRidesState();
}

class _SearchRidesState extends State<SearchRides> {
  final TextEditingController startWay = TextEditingController();
  final TextEditingController endWay = TextEditingController();

  bool _isPackageTransfer = false;
  bool _isTwoBackSeat = false;
  bool _isBagadgeTransfer = false;
  bool _isChildSeat = false;
  bool _isCondition = false;
  bool _isSmoking = false;
  bool _isPetTransfer = false;
  bool _isPickUpFromHome = false;

  @override
  Widget build(BuildContext context) {
    final rideDb = Provider.of<MyDatabase>(context).rideDao;

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
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: startWay.text.isNotEmpty ||
                            endWay.text.isNotEmpty ||
                            _isPackageTransfer == true ||
                            _isTwoBackSeat == true ||
                            _isBagadgeTransfer == true ||
                            _isChildSeat == true ||
                            _isCondition == true ||
                            _isSmoking == true ||
                            _isPetTransfer == true ||
                            _isPickUpFromHome == true
                        ? filteredRides(rideDb, startWay.text, endWay.text,
                            _isPackageTransfer)
                        : allRides(rideDb),
                  )
                ],
              ))),
    );
  }

  Widget filteredRides(
      RideDao rideDb, String startWay, String endWay, bool _isPackageTransfer) {
    return StreamBuilder<List<RideData>>(
        stream: rideDb.getFilteredRides(
            from: startWay, to: endWay, isPackageTransfer: _isPackageTransfer),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final rides = snapshot.data ?? [];
            return rides.isNotEmpty
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: rides.length,
                    itemBuilder: (context, int index) => RideTile(
                          rideData: rides[index],
                        ))
                : const Center(
                    child: Text("Поездок по вашему фильтру не найдено"),
                  );
          }
          return const Center(
            child: Text("Поездок еще нет"),
          );
        });
  }

  Widget allRides(RideDao rideDb) {
    return StreamBuilder<List<RideData>>(
        stream: rideDb.getAllRides(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final rides = snapshot.data ?? [];
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: rides.length,
                itemBuilder: (context, int index) => RideTile(
                      rideData: rides[index],
                    ));
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Column(
                children: [
                  WayPointField(
                      type: WaypointType.start,
                      textField: KFormField(
                        hintText: "Откуда",
                        textEditingController: startWay,
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
                        hintText: "Куда",
                        textEditingController: endWay,
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
        preferredSize: const Size(200, 230));
  }
}
