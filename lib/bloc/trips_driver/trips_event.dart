part of 'trips_bloc.dart';

@immutable
abstract class TripsEvent {}

class LoadAllTripsList extends TripsEvent {
  final int? page;
  final Departure? departure;
  final Departure? destination;
  final bool? animals;
  final bool? package;
  final bool? baggage;
  final bool? babyChair;
  final bool? smoke;
  final bool? twoPlacesInBehind;
  final bool? conditioner;
  final String? gender;
  final int? start;
  final int? end;

  LoadAllTripsList(
      {this.page,
      this.departure,
      this.destination,
      this.animals,
      this.package,
      this.baggage,
      this.babyChair,
      this.smoke,
      this.twoPlacesInBehind,
      this.conditioner,
      this.gender,
      this.start,
      this.end,});
}

class UpdateTripsList extends TripsEvent {
  final List<TripModel>? trips;

  UpdateTripsList(this.trips);
}

class AddReview extends TripsEvent {
  final BuildContext context;
  final int id;
  final String message;
  final int mark;

  AddReview(this.context, this.id, this.message, this.mark);
}

class CreateUserTrip extends TripsEvent {
  final BuildContext context;
  final TripModel trip;

  CreateUserTrip(this.context, this.trip);
}

class BookThisTrip extends TripsEvent {
  final BuildContext context;
  final List<int?> seats;
  final int tripId;

  BookThisTrip(this.context, this.seats, this.tripId);
}

class BookThisPackage extends TripsEvent {
  final BuildContext context;
  final List<int> seats;
  final int tripId;

  BookThisPackage(this.context, this.seats, this.tripId);
}

class DeleteTrip extends TripsEvent {
  final int tripId;

  DeleteTrip(this.tripId);
}

class DeletePassengerInTrip extends TripsEvent {
  final int tripId;
  final int userId;

  DeletePassengerInTrip(this.tripId, this.userId);
}

class ThrowAllTripsError extends TripsEvent {}
