part of 'trips_passenger_bloc.dart';

@immutable
abstract class TripsPassengerEvent {}

class LoadPassengerTripsList extends TripsPassengerEvent {
  final Departure? departure;
  final Departure? destination;
  final bool? animals;
  final bool? package;
  final bool? baggage;
  final bool? babyChair;
  final bool? smoke;
  final bool? twoPlacesInBehind;
  final bool? conditioner;

  LoadPassengerTripsList(
      {this.departure,
      this.destination,
      this.animals,
      this.package,
      this.baggage,
      this.babyChair,
      this.smoke,
      this.twoPlacesInBehind,
      this.conditioner});
}

class UpdateTripsList extends TripsPassengerEvent {
  final List<TripModel>? trips;

  UpdateTripsList(this.trips);
}

class CreatePassangerTrip extends TripsPassengerEvent {
  final BuildContext context;
  final TripModel trip;

  CreatePassangerTrip(this.context, this.trip);
}

class ThrowTipsError extends TripsPassengerEvent {}
