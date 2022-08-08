import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/src/trips/components/trip_tile_default.dart';
import 'package:flutter/material.dart';

class TripsList extends StatelessWidget {
  final List<TripModel> trips;
  const TripsList({Key? key, required this.trips}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (trips.isNotEmpty) {
      return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: trips.length,
          itemBuilder: (context, index) => TripTileDefault(
                trip: trips[index],
              ));
    } else {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Text("Поездки не найдены"),
        ),
      );
    }
    
  }
}
