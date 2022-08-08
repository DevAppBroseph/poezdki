part of 'trips_bloc.dart';

@immutable
abstract class TripsState {
  List<Object> get props => [];
}

class TripsInitial extends TripsState {}

class TripsLoading extends TripsState {}

class TripsLoaded extends TripsState {
  final List<TripModel> trips;

  TripsLoaded(this.trips);
  @override
  List<Object> get props => [
        trips,
      ];
}

class TripsError extends TripsState {}
