part of 'trips_passenger_bloc.dart';

@immutable
abstract class TripsPassengerState {}

class TripsInitial extends TripsPassengerState {}

class TripsLoading extends TripsPassengerState {}

class TripsLoaded extends TripsPassengerState {
  final List<TripModel> trips;

  TripsLoaded(this.trips);
}

class TripsError extends TripsPassengerState {}
