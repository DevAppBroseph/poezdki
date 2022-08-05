import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/service/server/trip_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'trips_passenger_event.dart';
part 'trips_passenger_state.dart';

class TripsPassengerBloc extends Bloc<TripsPassengerEvent, TripsPassengerState> {
  final tripService = TripService();
  TripsPassengerBloc() : super(TripsInitial()) {
    on<LoadPassengerTripsList>(_loadPassengerTripsList);
    on<UpdateTripsList>(_updateTripsList);
    on<ThrowTipsError>(_throwTripsError);
  }

  void _loadPassengerTripsList(LoadPassengerTripsList event, Emitter<TripsPassengerState> emit) async {
    emit(TripsLoading());
    final trips = await tripService.getAllDriversTrips(
        departure: event.departure,
        destination: event.destination,
        animals: event.animals,
        package: event.package,
        baggage: event.baggage,
        babyChair: event.babyChair,
        smoke: event.smoke,
        twoPlacesInBehind: event.twoPlacesInBehind,
        conditioner: event.conditioner);
    trips != null ? add(UpdateTripsList(trips)) : add(ThrowTipsError());
  }

  void _updateTripsList(UpdateTripsList event, Emitter<TripsPassengerState> emit) {
    emit(TripsLoaded(event.trips ?? []));
  }

  void _throwTripsError(ThrowTipsError event, Emitter<TripsPassengerState> emit) {}
}

