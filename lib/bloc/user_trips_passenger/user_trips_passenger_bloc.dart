import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/service/server/trip_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_trips_passenger_event.dart';
part 'user_trips_passenger_state.dart';

class UserTripsPassengerBloc
    extends Bloc<UserTripsPassengerEvent, UserTripsPassengerState> {
  final tripService = TripService();
  UserTripsPassengerBloc() : super(UserTripsPassengerInitial()) {
    on<LoadUserPassengerTripsList>(_loadUserPassengerTrips);
    on<UpdateUserPassengerTripsList>(_updateUserPassengerTrips);
    on<CancelBookTrip>(_cancelBookTrip);
  }

  void _loadUserPassengerTrips(LoadUserPassengerTripsList event,
      Emitter<UserTripsPassengerState> emit) async {
    emit(UserTripsPassengerLoading());
    final trips = await tripService.loadUserPassangerTrips();
    add(UpdateUserPassengerTripsList(trips));
  }

  void _updateUserPassengerTrips(UpdateUserPassengerTripsList event,
      Emitter<UserTripsPassengerState> emit) async {
    emit(UserTripsPassengerLoaded(event.trips!));
  }

  void _cancelBookTrip(
      CancelBookTrip event, Emitter<UserTripsPassengerState> emit) async {
    await tripService.cancelBookTrip(tripId: event.bookId);
    add(LoadUserPassengerTripsList());
  }
}
