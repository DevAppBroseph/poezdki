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
          if (state.trips.isNotEmpty) {
            return UserTripsList(
              tripsLists: state.trips,
              screen: 1,
            );
          } else {
            return Container();
          }
        }
        return const Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }),
    );
  }
}
