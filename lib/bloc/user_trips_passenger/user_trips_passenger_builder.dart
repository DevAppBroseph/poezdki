import 'package:app_poezdka/bloc/user_trips_passenger/user_trips_passenger_bloc.dart';
import 'package:app_poezdka/src/trips/components/user_trips_list.dart';
import 'package:flutter/material.dart';

import '../../export/blocs.dart';

class UserTripsPassengerBuilder extends StatelessWidget {
  const UserTripsPassengerBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userTripsBloc = BlocProvider.of<UserTripsPassengerBloc>(context);
    return BlocBuilder(
        bloc: userTripsBloc,
        builder: ((context, state) {
          if (state is UserTripsPassengerLoading) {
            return const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is UserTripsPassengerLoaded) {
            return UserTripsList(
              tripsLists: state.trips,
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
