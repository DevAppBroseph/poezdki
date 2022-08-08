import 'package:app_poezdka/bloc/user_trips_driver/user_trips_driver_builder.dart';
import 'package:app_poezdka/bloc/user_trips_passenger/user_trips_passenger_builder.dart';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/export/services.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/src/rides/components/ride_tile.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';

class UserTripsScreen extends StatefulWidget {
  const UserTripsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserTripsScreen> createState() => _UserTripsScreenState();
}

class _UserTripsScreenState extends State<UserTripsScreen>
    with SingleTickerProviderStateMixin {
  final userRepo = SecureStorage.instance;

  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
        resizeToAvoidBottomInset: false,
        title: "Мои поездки",
        bottom: _tabbar(),
        body: Container(
            color: kPrimaryWhite,
            child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SingleChildScrollView(
                    child: Column(
                      // children: [],
                      children: const [UserTripsPassengerBuilder()],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      // children: [],
                      children: const [UserTripsDriverBuilder()],
                    ),
                  ),
                ])));
  }

  Widget futureRides() {
    return Column(
      children: const [
        ListTile(
          title: Text(
            "Предстоящие поездки",
            style: TextStyle(color: Colors.grey),
          ),
        ),

        // FutureBuilder<UserData?>(
        //   future: dbUser.getUserData(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       return StreamBuilder<List<RideData>>(
        //           stream: rideDb.streamMyUpcominRides(snapshot.data!.id!),
        //           builder: (context, snap) {
        //             if (snap.connectionState == ConnectionState.active) {
        //               final rides = snap.data ?? [];
        //               return ListView.builder(
        //                   physics: const NeverScrollableScrollPhysics(),
        //                   shrinkWrap: true,
        //                   itemCount: rides.length,
        //                   itemBuilder: (context, int index) =>
        //                       RideTile(rideData: rides[index], isUpcoming: true,));
        //             }
        //             return const CircularProgressIndicator();
        //           });
        //     }
        //     return const CircularProgressIndicator();
        //   },
        // ),
      ],
    );
  }

  Widget pastRides(context, List<TripModel>? pastRidesDriver) {
    if (pastRidesDriver != null && pastRidesDriver.isNotEmpty) {
      return Column(
        children: [
          const ListTile(
            title: Text(
              "Прошедшие поездки",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ListView.builder(
              itemCount: pastRidesDriver.length,
              itemBuilder: (context, index) =>
                  RideTile(tripData: pastRidesDriver[index]))
        ],
      );
    }
    return const SizedBox();
  }

  PreferredSizeWidget _tabbar() {
    return PreferredSize(
      preferredSize: const Size(100, 80),
      child: TabBar(
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
    );
  }
}
