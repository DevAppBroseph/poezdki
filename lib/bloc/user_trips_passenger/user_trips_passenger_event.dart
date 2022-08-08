part of 'user_trips_passenger_bloc.dart';

@immutable
abstract class UserTripsPassengerEvent {}

class LoadUserPassengerTripsList extends UserTripsPassengerEvent {}

class UpdateUserPassengerTripsList extends UserTripsPassengerEvent {
  final List<List<TripModel>>? trips;

  UpdateUserPassengerTripsList(this.trips);
}

class CancelBookTrip extends UserTripsPassengerEvent {
  final int bookId;

  CancelBookTrip(this.bookId);
}

class ThrowUserPassengerTripsList extends UserTripsPassengerEvent {}
