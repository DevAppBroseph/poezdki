import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/service/server/trip_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'trips_event.dart';
part 'trips_state.dart';

class TripsBloc extends Bloc<TripsEvent, TripsState> {
  final tripService = TripService();
  TripsBloc() : super(TripsInitial()) {
    on<LoadAllTripsList>(_loadTripsList);
    on<UpdateTripsList>(_updateTripsList);
    on<CreateUserTrip>(_createTrip);
    on<BookThisTrip>(_bookTrip);
    on<DeleteTrip>(_deleteTrip);
    on<ThrowAllTripsError>(_throwTripsError);
  }

  void _loadTripsList(LoadAllTripsList event, Emitter<TripsState> emit) async {
    emit(TripsLoading());
    final trips = await tripService.getAllTrips(
        departure: event.departure?.toJson().toString(),
        destination: event.destination?.toJson().toString(),
        animals: event.animals,
        package: event.package,
        baggage: event.baggage,
        babyChair: event.babyChair,
        smoke: event.smoke,
        twoPlacesInBehind: event.twoPlacesInBehind,
        conditioner: event.conditioner,
        gender: event.gender);
    trips != null ? add(UpdateTripsList(trips)) : add(ThrowAllTripsError());
  }

  void _updateTripsList(UpdateTripsList event, Emitter<TripsState> emit) {
    emit(TripsLoaded(event.trips ?? []));
  }

  void _createTrip(CreateUserTrip event, Emitter<TripsState> emit) async {
    final success = await tripService.createTripDriver(
        context: event.context, trip: event.trip);
    if (success) add(LoadAllTripsList());
  }

  void _bookTrip(BookThisTrip event, Emitter<TripsState> emit) async {
    final success = await tripService.bookTrip(event.context,
        seats: event.seats, tripId: event.tripId);
    if (success) add(LoadAllTripsList());
  }



  void _deleteTrip(DeleteTrip event, Emitter<TripsState> emit) async {
    await tripService.deleteTrip(event.tripId);
    add(LoadAllTripsList());
  }

  void _throwTripsError(ThrowAllTripsError event, Emitter<TripsState> emit) {}
}
