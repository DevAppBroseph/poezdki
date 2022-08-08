import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/service/server/trip_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_trips_driver_event.dart';
part 'user_trips_driver_state.dart';

class UserTripsDriverBloc
    extends Bloc<UserTripsDriverEvent, UserTripsDriverState> {
  final tripService = TripService();
  UserTripsDriverBloc() : super(UserTripsDriverInitial()) {
    on<LoadUserTripsList>(_loadUserTrips);
    on<UpdateUserTripsList>(_updateUserTrips);
  }

  void _loadUserTrips(
      LoadUserTripsList event, Emitter<UserTripsDriverState> emit) async {
    emit(UserTripsDriverLoading());
    final trips = await tripService.loadUserDriverTrips();
    add(UpdateUserTripsList(trips));
  }

  void _updateUserTrips(
      UpdateUserTripsList event, Emitter<UserTripsDriverState> emit) async {
    emit(UserTripsDriverLoaded(event.trips!));
  }
}
