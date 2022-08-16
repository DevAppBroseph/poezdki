import 'package:app_poezdka/bloc/trips_driver/trips_bloc.dart';
import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/src/trips/components/trip_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserTripsList extends StatelessWidget {
  final List<List<TripModel>> tripsLists;
  const UserTripsList({Key? key, required this.tripsLists}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TripModel> upcomingTrips = tripsLists[0];
    final List<TripModel> pastTrips = tripsLists[1];
    return Container(
      // width: double.infinity,
      // height: MediaQuery.of(context).size.height,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverRefreshControl(onRefresh: () async {
            BlocProvider.of<TripsBloc>(context).add(LoadAllTripsList());
          }),
          SliverToBoxAdapter(
            child: pastList(pastTrips),
          ),
          SliverToBoxAdapter(
            child: upcomingList(upcomingTrips),
          ),
          // SliverToBoxAdapter(
          //   child: SingleChildScrollView(

          //     child: Column(
          //       children: [pastList(pastTrips), upcomingList(upcomingTrips)],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget pastList(List<TripModel> pastTrips) {
    if (pastTrips.isNotEmpty) {
      return Column(
        children: [
          const ListTile(
            title: Text(
              "Прошедшие поездки",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: pastTrips.length,
            itemBuilder: (context, index) => TripTile(
              trip: pastTrips[index],
            ),
          ),
        ],
      );
    }
    return const SizedBox();
  }

  Widget upcomingList(List<TripModel> upcoming) {
    if (upcoming.isNotEmpty) {
      return Column(
        children: [
          const ListTile(
            title: Text(
              "Предстоящие поездки",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: upcoming.length,
              itemBuilder: (context, index) => TripTile(
                    trip: upcoming[index],
                  ))
        ],
      );
    }
    return const SizedBox();
  }
}
