// // ignore_for_file: unused_import

// import 'package:app_poezdka/database/database.dart';
// import 'package:app_poezdka/database/table/ride.dart';
// import 'package:app_poezdka/export/services.dart';
// import 'package:app_poezdka/model/trip_model.dart';
// import 'package:app_poezdka/service/server/trip_service.dart';
// import 'package:bloc/bloc.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;

// part 'my_rides_event.dart';
// part 'my_rides_state.dart';

// class MyRidesBloc extends Bloc<MyRidesEvent, MyRidesState> {
//   final SecureStorage userRepository;
//   MyRidesBloc(this.userRepository) : super(MyRidesLoading()) {
//     on<LoadMyRides>(_onLoadMyRides);
//     // on<AddMyRide>(_onAddMyRide);
//   }

//   void _onLoadMyRides(LoadMyRides event, Emitter<MyRidesState> emit) async {
//     final tripService = TripService();
//     emit(MyRidesLoading());
//     try {
//       final token = await userRepository.getToken();
//       final pastRidesDriver =
//           await tripService.getAllDriverTrips(token: token!);

//       emit(MyRidesLoaded(pastRidesDriver?.trips));
//     } catch (e) {
//       if (kDebugMode) {
//       }
//     }
//   }

//   // void _onAddMyRide(AddMyRide event, Emitter<MyRidesState> emit) async {
//   //   emit(MyRidesLoading());
//   //   final regUrl = Uri.parse("http://ystories.site:70/trips/add_trip");
//   //   final end = DateTime.now();
//   //   Map<String, dynamic> params = {
//   //     "car": 1,
//   //     "price": 200,
//   //     "departure": event.startWay,
//   //     "destination": event.startWay,
//   //     "start": DateTime.now().millisecondsSinceEpoch,
//   //     "end": end
//   //   };
//   //   try {
//   //     var body = json.encode(params);
//   //     var response = await http.post(regUrl,
//   //         headers: {"Accept": "application/json"}, body: body);
//   //     if (response.statusCode == 200) {
//   //       Map<String, dynamic> body = json.decode(response.body);
//   //       final String owner = body['owner'];
//   //       owner != null ? print("success") : throw (response.statusCode);

//   //     } else {
//   //       if (response.statusCode == 400) {}
//   //     }
//   //   } catch (e) {
//   //   }
//   // }
// }
