import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_poezdka/export/server_url.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/widget/dialog/error_dialog.dart';

class TripService {
  final errorDialog = ErrorDialogs();
  static var getAllDriverRides = Uri.parse(getDriverTripsUrl);
  // static var getAllPassengerTrips = Uri.parse(getPassengerTripsUrl);
  // static var getAllPassangerRides = Uri.parse(getPassTripsUrl);
  // static var getUserRidesDriver = Uri.parse(getDriverPastTripsUrl);
  // static var getUserRidesPassanger = Uri.parse(getPassPastTripsUrl);

  Future<List<TripModel>?> getAllDriverTrips(
      {String? departure,
      String? destination,
      bool? animals,
      bool? package,
      bool? baggage,
      bool? babyChair,
      bool? smoke,
      bool? twoPlacesInBehind,
      bool? conditioner}) async {
    final filter = {
      if(departure != null)
        "departure": departure,
       if(destination != null)
      "destination": destination,
      "animals": "${animals ?? false}",
      "package": "${package ?? false}",
      "baggage": "${baggage ?? false}",
      "baby_chair": "${babyChair ?? false}",
      "two_places_in_behind": "${twoPlacesInBehind ?? false}",
      "conditioner": "${conditioner ?? false}"
    };
    Response response;
    var dio = Dio();
    // final allTrips = Uri.http('194.87.145.140', '/trips/get_all_trips', filter);
    // final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    try {
      // var response = await http.get(allTrips);
      response = await dio.post('http://194.87.145.140/trips/get_all_trips',
          data: json.encode(filter));

      if (response.statusCode == 200) {
        final list = response.data['all_trips'] as List;

        List<TripModel> trips = [];
        list.map((e) {
          print(e);
          trips.add(TripModel.fromJson(e));
        }).toList();
        print(trips.length);
        return trips;
      } else {
        throw Exception('Ошибка сервера. Код ошибки: ${response.statusCode}');
      }
    } catch (e) {
      errorDialog.showError(e.toString());
      return null;
    }
  }
}
