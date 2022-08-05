import 'package:app_poezdka/bloc/trips_driver/trips_bloc.dart';
import 'package:app_poezdka/src/trips/components/trips_list.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class TripsBuilder extends StatelessWidget {
  const TripsBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tripsBloc = BlocProvider.of<TripsBloc>(context);
    return BlocBuilder(
        bloc: tripsBloc,
        builder: ((context, state) {
          if (state is TripsLoading) {
            return const Padding(
              padding:  EdgeInsets.all(20.0),
              child:  Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is TripsLoaded) {
            return TripsList(
              trips: state.trips,
            );
          }
          return const Center(
            child: Text("No state detected"),
          );
        }));
  }
}
