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
    on<BookThisPackage>(_bookPackage);
    on<DeleteTrip>(_deleteTrip);
    on<DeletePassengerInTrip>(_deletePassengerInTrip);
    on<AddReview>(_addReview);
    on<ThrowAllTripsError>(_throwTripsError);
    on<CreateTripLoad>(_creatTripLoad);
  }

  void _creatTripLoad(CreateTripLoad event, Emitter<TripsState> emit) {
    emit(TripsLoadingTime());
  }

  void _loadTripsList(LoadAllTripsList event, Emitter<TripsState> emit) async {
    emit(TripsLoading());
    final trips = await tripService.getAllTrips(
      departure: event.departure?.toJson(),
      destination: event.destination?.toJson(),
      animals: event.animals,
      package: event.package,
      baggage: event.baggage,
      babyChair: event.babyChair,
      smoke: event.smoke,
      twoPlacesInBehind: event.twoPlacesInBehind,
      conditioner: event.conditioner,
      gender: event.gender,
      start: event.start,
      end: event.end,
    );
    trips != null ? add(UpdateTripsList(trips)) : add(ThrowAllTripsError());
  }

  void _updateTripsList(UpdateTripsList event, Emitter<TripsState> emit) {
    emit(TripsLoaded(event.trips ?? []));
  }

  void _createTrip(CreateUserTrip event, Emitter<TripsState> emit) async {
    emit(TripsLoadingTime());
    print('object send trips log _createTrip');
    final success = await tripService.createTripDriver(
        context: event.context, trip: event.trip);
    if (success) {
      emit(TripsCreateSuccess());
      add(LoadAllTripsList());
    } else {
      emit(TripsCreateError());
    }
  }

  void _bookTrip(BookThisTrip event, Emitter<TripsState> emit) async {
    final success = await tripService.bookTrip(
      event.context,
      seats: event.seats,
      tripId: event.tripId,
    );
    if (success) {
      add(LoadAllTripsList());
      emit(TripsCreateSuccess());
    }
  }

  void _bookPackage(BookThisPackage event, Emitter<TripsState> emit) async {
    final success = await tripService.bookPackage(
      event.context,
      seats: event.seats,
      tripId: event.tripId,
    );
    if (success) add(LoadAllTripsList());
  }

  void _deleteTrip(DeleteTrip event, Emitter<TripsState> emit) async {
    await tripService.deleteTrip(event.tripId);
    add(LoadAllTripsList());
  }

  void _deletePassengerInTrip(
      DeletePassengerInTrip event, Emitter<TripsState> emit) async {
    await tripService.cancelPassengerInTrip(
        tripId: event.tripId, userId: event.userId);
    add(LoadAllTripsList());
  }

  void _addReview(AddReview event, Emitter<TripsState> emit) async {
    await tripService.addReview(event.id, event.message, event.mark);
    Navigator.pop(event.context);
    // add(LoadAllTripsList());
  }

  void _throwTripsError(ThrowAllTripsError event, Emitter<TripsState> emit) {}
}
