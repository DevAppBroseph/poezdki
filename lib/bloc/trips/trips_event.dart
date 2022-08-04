part of 'trips_bloc.dart';

@immutable
abstract class TripsEvent {}

class InitTrips extends TripsEvent {}

class LoadTipsList extends TripsEvent {
  final String? departure;
  final String? destination;
  final bool? animals;
  final bool? package;
  final bool? baggage;
  final bool? babyChair;
  final bool? smoke;
  final bool? twoPlacesInBehind;
  final bool? conditioner;

  LoadTipsList(
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

class UpdateTripsList extends TripsEvent {
  final List<TripModel>? trips;

  UpdateTripsList(this.trips);
}

class ThrowTipsError extends TripsEvent {}
