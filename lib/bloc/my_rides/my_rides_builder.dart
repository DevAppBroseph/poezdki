import 'package:app_poezdka/bloc/my_rides/my_rides_bloc.dart';
import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/src/rides/rides_screen.dart';
import 'package:flutter/material.dart';

class MyRidesBuilder extends StatelessWidget {
  const MyRidesBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ridesBloc = BlocProvider.of<MyRidesBloc>(context);
    return BlocBuilder(
        bloc: ridesBloc,
        builder: ((context, state) {
          if (state is MyRidesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MyRidesLoaded) {
            return RidesScreen(
              rides: state.rides,
            );
          }
          return const Center(
            child: Text("No state detected"),
          );
        }));
  }
}
