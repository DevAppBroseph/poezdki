part of 'user_trips_driver_bloc.dart';

@immutable
abstract class UserTripsDriverState {
  List<Object> get props => [];
}

class UserTripsDriverInitial extends UserTripsDriverState {}

class UserTripsDriverLoading extends UserTripsDriverState {}

class UserTripsDriverLoaded extends UserTripsDriverState {
  final List<List<TripModel>> trips;

  UserTripsDriverLoaded(this.trips);
  @override
  List<Object> get props => [
        trips,
      ];
}

class UserTripsError extends UserTripsDriverState {}
