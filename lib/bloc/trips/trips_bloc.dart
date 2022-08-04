import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/service/server/trip_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'trips_event.dart';
part 'trips_state.dart';

class TripsBloc extends Bloc<TripsEvent, TripsState> {
  final tripService = TripService();
  TripsBloc() : super(TripsInitial()) {
    on<InitTrips>(_initTripsList);
    on<LoadTipsList>(_loadTripsList);
    on<UpdateTripsList>(_updateTripsList);
    on<ThrowTipsError>(_throwTripsError);
  }

  void _initTripsList(InitTrips event, Emitter<TripsState> emit) {
    emit(TripsLoading());
    add(LoadTipsList());
  }

  void _loadTripsList(LoadTipsList event, Emitter<TripsState> emit) async {
    emit(TripsLoading());
    final trips = await tripService.getAllDriverTrips(
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

  void _updateTripsList(UpdateTripsList event, Emitter<TripsState> emit) {
    emit(TripsLoaded(event.trips ?? []));
  }

  void _throwTripsError(ThrowTipsError event, Emitter<TripsState> emit) {}
}
