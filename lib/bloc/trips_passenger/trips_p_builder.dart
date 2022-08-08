import 'package:app_poezdka/bloc/trips_passenger/trips_passenger_bloc.dart';
import 'package:app_poezdka/export/blocs.dart';
import 'package:flutter/material.dart';

import '../../src/trips/components/trips_list.dart';


class TripsPassengerBuilder extends StatelessWidget {
  const TripsPassengerBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final tripsBloc = BlocProvider.of<TripsPassengerBloc>(context);
    return BlocBuilder(
        bloc: tripsBloc,
        builder: ((context, state) {
          if (state is TripsLoading) {
            return const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is TripsLoaded) {
            return TripsList(
              trips: state.trips,
            );
          }
          return const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
        }));
  }
}