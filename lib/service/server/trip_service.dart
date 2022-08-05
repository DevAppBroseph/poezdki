import 'package:app_poezdka/model/city_model.dart';
import 'package:app_poezdka/model/server_responce.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_poezdka/export/server_url.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/widget/dialog/error_dialog.dart';

class TripService {
  final errorDialog = ErrorDialogs();

  Future<List<TripModel>?> getAllTrips(
      {String? departure,
      String? destination,
      bool? animals,
      bool? package,
      bool? baggage,
      bool? babyChair,
      bool? smoke,
      bool? twoPlacesInBehind,
      bool? conditioner}) async {
    Map<String, dynamic> filter = {
      // if (departure != null) "departure": departure,
      // if (destination != null) "destination": destination,
      "animals": animals,
      "package": package,
      "baggage": baggage,
      "baby_chair": babyChair,
      "smoke": smoke,
      "two_places_in_behind": twoPlacesInBehind,
      "conditioner": conditioner
    };
    // Response response;
    // var dio = Dio();

    try {
      // var response = await http.get(allTrips);
      final userHeader = {
        "Content-type": "application/json",
        "Accept": "application/json"
      };
      var response = await http.post(Uri.parse(getAllTripsUrl),
          body: json.encode(filter), headers: userHeader);

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final list = body['all_trips'] as List;

        List<TripModel> trips = [];
        list.map((e) {
          trips.add(TripModel.fromJson(e));
        }).toList();
        return trips;
      } else {
        throw Exception('Ошибка сервера. Код ошибки: ${response.statusCode}');
      }
    } catch (e) {
      errorDialog.showError(e.toString());
      return null;
    }
  }

  Future<List<TripModel>?> getAllDriversTrips(
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
      if (departure != null) "departure": departure,
      if (destination != null) "destination": destination,
      "animals": "${animals ?? false}",
      "package": "${package ?? false}",
      "baggage": "${baggage ?? false}",
      "baby_chair": "${babyChair ?? false}",
      "two_places_in_behind": "${twoPlacesInBehind ?? false}",
      "conditioner": "${conditioner ?? false}",
      "owner_gender": "male"
    };
    Response response;
    var dio = Dio();

    try {
      // var response = await http.get(allTrips);
      response =
          await dio.post(getAllDriverTripsUrl, data: json.encode(filter));

      if (response.statusCode == 200) {
        final list = response.data['all_trips'] as List;

        List<TripModel> trips = [];
        list.map((e) {
          trips.add(TripModel.fromJson(e));
        }).toList();
        return trips;
      } else {
        throw Exception('Ошибка сервера. Код ошибки: ${response.statusCode}');
      }
    } catch (e) {
      errorDialog.showError(e.toString());
      return null;
    }
  }

  Future createTripPassanger(
      {required int price,
      required int startTime,
      required City departure,
      required List<Stops> stops,
      required bool package,
      required bool baggage,
      required bool babyChair,
      required bool smoke,
      required bool animals,
      required bool twoPlacesInBehind}) async {
    Response response;
    var dio = Dio();
    final data = {
      "price": price,
      "start": startTime,
      "departure": departure.toMap(),
      "stops": stops,
      "package": package,
      "baggage": baggage,
      "baby_chair": babyChair,
      "smoke": smoke,
      "animals": animals,
      "two_places_in_behind": twoPlacesInBehind,
      "owner_gender": 'male'
    };

    try {
      response = await dio.post(addTripUrl, data: json.encode(data));
      final ResponceTripCreation responceData = response.data;
      if (responceData.success) {
        return responceData.success;
      } else {
        errorDialog.showError(responceData.status);
      }
    } catch (e) {
      errorDialog.showError(e.toString());
    }
  }

  Future createTripDriver(
      {required int car,
      required int price,
      required int startTime,
      required City departure,
      required List<Stops> stops,
      required bool package,
      required bool baggage,
      required bool babyChair,
      required bool smoke,
      required bool animals,
      required bool twoPlacesInBehind}) async {
    Response response;
    var dio = Dio();
    final data = {
      "car": car,
      "price": price,
      "start": startTime,
      "departure": departure.toMap(),
      "stops": stops,
      "package": package,
      "baggage": baggage,
      "baby_chair": babyChair,
      "smoke": smoke,
      "two_places_in_behind": twoPlacesInBehind,
    };

    try {
      response = await dio.post(addTripUrl, data: json.encode(data));
      final ResponceTripCreation responceData = response.data;
      if (responceData.success) {
        return responceData.success;
      } else {
        errorDialog.showError(responceData.status);
      }
    } catch (e) {
      errorDialog.showError(e.toString());
    }
  }
}
