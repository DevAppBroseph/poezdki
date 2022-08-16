import 'package:app_poezdka/model/server_responce.dart';
import 'package:app_poezdka/service/local/secure_storage.dart';
import 'package:app_poezdka/widget/dialog/info_dialog.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:app_poezdka/export/server_url.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/widget/dialog/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class TripService {
  final errorDialog = ErrorDialogs();

  Future<List<TripModel>?> getAllTrips(
      {Map? departure,
      Map? destination,
      bool? animals,
      bool? package,
      bool? baggage,
      bool? babyChair,
      bool? smoke,
      bool? twoPlacesInBehind,
      bool? conditioner,
      String? gender}) async {
    print(departure);
    print(destination);
    Map<String, dynamic> filter = {
      if (departure != null) "departure": departure,
      if (destination != null) "destination": destination,
      if (gender != null) "gender": gender,
      "animals": animals,
      "package": package,
      "baggage": baggage,
      "baby_chair": babyChair,
      "smoke": smoke,
      "two_places_in_behind": twoPlacesInBehind,
      "conditioner": conditioner
    };
    print(filter);
    Response response;
    var dio = Dio();

    try {
      // var response = await http.get(allTrips);
      final userHeader = {
        "Content-type": "application/json",
        "Accept": "application/json"
      };
      response = await dio.post(getAllTripsUrl,
          data: json.encode(filter), options: Options(headers: userHeader));
      if (response.statusCode == 200) {
        final body = response.data;
        final list = body['all_trips'] as List;
        print(response.data);

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
      "animals": animals,
      "package": package,
      "baggage": baggage,
      "baby_chair": babyChair,
      "smoke": smoke,
      "two_places_in_behind": twoPlacesInBehind,
      "conditioner": conditioner
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
      // errorDialog.showError(e.toString());
      return null;
    }
  }

  Future<bool> createTripPassanger({required TripModel trip}) async {
    Response response;
    var dio = Dio();
    final List stops = [];
    trip.stops?.forEach((element) async {
      stops.add(element.toJson());
    });
    final data = {
      "price": trip.price,
      "start": trip.timeStart,
      "departure": trip.departure?.toJson(),
      "stops": stops,
      "package": trip.package,
      "baggage": trip.baggage,
      "baby_chair": trip.babyChair,
      "smoke": trip.smoke,
      "animals": trip.animals,
      "two_places_in_behind": trip.twoPlacesInBehind,
      "conditioner": trip.conditioner
    };

    try {
      final token = await SecureStorage.instance.getToken();
      response = await dio.post(addTripUrl,
          data: json.encode(data),
          options: Options(
              headers: {"Authorization": token},
              responseType: ResponseType.json));
      final responceData = ResponceServerData.fromMap(response.data);

      if (responceData.success) {
        return responceData.success;
      } else {
        errorDialog.showError(responceData.status.toString());

        return responceData.success;
      }
    } catch (e) {
      errorDialog.showError(e.toString());
      return false;
    }
  }

  Future<bool> createTripDriver(
      {required BuildContext context, required TripModel trip}) async {
    Response response;
    var dio = Dio();

    final List stops = [];
    for (var item in trip.stops!) {
      final stop = item.toJson();
      stops.add(stop);
    }

    final data = {
      "car": trip.car!.pk,
      "price": trip.price,
      "start": trip.timeStart,
      "departure": trip.departure!.toJson(),
      "stops": stops,
      "package": trip.package,
      "baggage": trip.baggage,
      "baby_chair": trip.babyChair,
      "smoke": trip.smoke,
      "animals": trip.animals,
      "two_places_in_behind": trip.twoPlacesInBehind,
      "conditioner": trip.conditioner
    };

    try {
      final token = await SecureStorage.instance.getToken();
      response = await dio.post(addTripUrl,
          data: json.encode(data),
          options: Options(
              headers: {"Authorization": token},
              responseType: ResponseType.json));
      final responceData = ResponceServerData.fromMap(response.data);
      if (responceData.success == true) {
        InfoDialog().show(
          img: "assets/img/like.svg",
          title: "Ваша поездка создана!",
          description: "Ожидайте попутчиков.",
        );
        Navigator.pop(context, true);
        return responceData.success;
      } else {
        errorDialog.showError(responceData.status);
        return false;
      }
    } catch (e) {
      errorDialog.showError(e.toString());
      return false;
    }
  }

  Future<bool> bookTrip(context,
      {required int tripId, required List<int> seats}) async {
    Response response;
    var dio = Dio();
    final data = {
      "seats": seats,
    };
    try {
      final token = await SecureStorage.instance.getToken();
      response = await dio.post("$bookingTripUrl$tripId",
          data: json.encode(data),
          options: Options(
              headers: {"Authorization": token},
              responseType: ResponseType.json));
      final responceData = ResponceServerData.fromMap(response.data);
      if (responceData.success) {
        InfoDialog().show(
            title: "Ваше место забронировано!",
            img: "assets/img/like.svg",
            description:
                "Желаем вам хорошей поездки. Вы можете отменить свою поездку в разделе Профиль.",
            onPressed: () {
              SmartDialog.dismiss();
              Navigator.pop(context);
              Navigator.pop(context);
            });
        return responceData.success;
      } else {
        errorDialog.showError(responceData.status);
        return responceData.success;
      }
    } catch (e) {
      errorDialog.showError(e.toString());
      return false;
    }
  }

  Future<void> cancelBookTrip({
    required int tripId,
  }) async {
    Response res;
    var dio = Dio();

    try {
      print(tripId);
      final token = await SecureStorage.instance.getToken();
      res = await dio.delete("$cancelBookingTripUrl$tripId",
          options: Options(
              headers: {"Authorization": token},
              responseType: ResponseType.json));
      print(res);
    } catch (e) {
      errorDialog.showError(e.toString());
    }
  }

  Future<List<List<TripModel>>> loadUserDriverTrips() async {
    List<Response> responses;
    var dio = Dio();

    try {
      final token = await SecureStorage.instance.getToken();
      final options = Options(
          headers: {"Authorization": token}, responseType: ResponseType.json);
      responses = await Future.wait([
        dio.get(getDriverTripsUrl, options: options),
        dio.get(getDriverPastTripsUrl, options: options),
      ]);
      return [
        _getTripsFromRequest(responses[0]),
        _getTripsFromRequest(responses[1]),
      ];
    } catch (e) {
      return [];
    }
  }

  Future<List<List<TripModel>>> loadUserPassangerTrips() async {
    List<Response> responses;
    var dio = Dio();

    try {
      final token = await SecureStorage.instance.getToken();
      final options = Options(
          headers: {"Authorization": token}, responseType: ResponseType.json);
      responses = await Future.wait([
        dio.get(getPassengerTripsUrl, options: options),
        dio.get(getPassPastTripsUrl, options: options),
      ]);
      return [
        _getTripsFromRequest(responses[0]),
        _getTripsFromRequest(responses[1]),
      ];
    } catch (e) {
      return [];
    }
  }

  List<TripModel> _getTripsFromRequest(Response response) {
    return [
      if (response.statusCode == 200)
        for (var i in response.data['trips']) TripModel.fromJson(i),
    ];
  }

  Future<void> deleteTrip(int tripId) async {
    final dio = Dio();
    try {
      final token = await SecureStorage.instance.getToken();
      final options = Options(
          headers: {"Authorization": token}, responseType: ResponseType.json);
      await dio.delete("$deleteTripUrl$tripId", options: options);
    } catch (e) {
      print(e.toString());
    }
  }
}