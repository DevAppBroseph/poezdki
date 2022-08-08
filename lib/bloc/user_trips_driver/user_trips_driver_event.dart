part of 'user_trips_driver_bloc.dart';

@immutable
abstract class UserTripsDriverEvent {}

class LoadUserTripsList extends UserTripsDriverEvent {}

class UpdateUserTripsList extends UserTripsDriverEvent {
  final List<List<TripModel>>? trips;

  UpdateUserTripsList(this.trips);
}

class ThrowUserTripsList extends UserTripsDriverEvent {}
