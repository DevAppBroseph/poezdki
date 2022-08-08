import 'package:app_poezdka/bloc/user_trips_driver/user_trips_driver_bloc.dart';
import 'package:app_poezdka/src/trips/components/user_trips_list.dart';
import 'package:flutter/material.dart';

import '../../export/blocs.dart';

class UserTripsDriverBuilder extends StatelessWidget {
  const UserTripsDriverBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userTripsBloc = BlocProvider.of<UserTripsDriverBloc>(context);
    return BlocBuilder(
        bloc: userTripsBloc,
        builder: ((context, state) {
          if (state is UserTripsDriverLoading) {
            return const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is UserTripsDriverLoaded) {
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
