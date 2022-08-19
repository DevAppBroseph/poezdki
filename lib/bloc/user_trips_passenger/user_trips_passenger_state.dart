part of 'user_trips_passenger_bloc.dart';

@immutable
abstract class UserTripsPassengerState {
  List<Object> get props => [];
}

class UserTripsPassengerInitial extends UserTripsPassengerState {}

class UserTripsPassengerLoading extends UserTripsPassengerState {}

class UserTripsPassengerLoaded extends UserTripsPassengerState {
  final List<List<TripModel>>? trips;

  UserTripsPassengerLoaded(this.trips);
  @override
  List<Object> get props => [
        trips!,
      ];
}

class UserTripsPassengerError extends UserTripsPassengerState {}
