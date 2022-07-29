part of 'my_rides_bloc.dart';

class MyRidesState {}

class MyRidesInitial extends MyRidesState {}

class MyRidesLoading extends MyRidesState {}

class MyRidesLoaded extends MyRidesState {
  final List<RideData> rides;

  MyRidesLoaded(this.rides);
}
