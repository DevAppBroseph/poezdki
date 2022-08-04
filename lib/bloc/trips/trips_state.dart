part of 'trips_bloc.dart';

@immutable
abstract class TripsState {}

class TripsInitial extends TripsState {}

class TripsLoading extends TripsState {}

class TripsLoaded extends TripsState {
  final List<TripModel> trips;

  TripsLoaded(this.trips);
}

class TripsError extends TripsState {}
