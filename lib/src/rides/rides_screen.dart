import 'package:app_poezdka/bloc/my_rides/my_rides_bloc.dart';
import 'package:app_poezdka/bloc/my_rides/my_rides_builder.dart';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/database/database.dart';
import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/export/services.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RidesScreen extends StatefulWidget {
  final List? rides;
  const RidesScreen({Key? key, this.rides}) : super(key: key);

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen>
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
    final rideBloc = BlocProvider.of<MyRidesBloc>(context);
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
                      children: [],
                      // children: [futureRides(), pastRides()],
                    ),
                  ),
                  Center(
                    child: FullWidthElevButton(
                      title: "Hi",
                      onPressed: () => rideBloc
                        ..add(AddMyRide(startWay: "start", endWay: "end", childSeat: true)),
                    ),
                  ),
                ])));
  }

  Widget futureRides() {

    return Column(
      children: const[
        ListTile(
          title: Text(
            "Предстоящие поездки",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        MyRidesBuilder()
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

  Widget pastRides() {
    final rideDb = Provider.of<MyDatabase>(context).rideDao;
    final dbUser = Provider.of<MyDatabase>(context, listen: false).userDao;
    return Column(
      children: const[
         ListTile(
          title: Text(
            "Прошедшие поездки",
            style: TextStyle(color: Colors.grey),
          ),
        ),
         MyRidesBuilder()
        // FutureBuilder<UserData?>(
        //   future: dbUser.getUserData(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       return StreamBuilder<List<RideData>>(
        //           stream: rideDb.streamMyPastRides(snapshot.data!.id!),
        //           builder: (context, snap) {
        //             if (snap.connectionState == ConnectionState.active) {
        //               final rides = snap.data ?? [];
        //               return ListView.builder(
        //                   physics: const NeverScrollableScrollPhysics(),
        //                   shrinkWrap: true,
        //                   itemCount: rides.length,
        //                   itemBuilder: (context, int index) =>
        //                       RideTile(rideData: rides[index]));
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
            text: 'Пассажир',
          ),

          // second tab [you can add an icon using the icon property]
          Tab(
            text: 'Водитель',
          ),
        ],
      ),
    );
  }
}
