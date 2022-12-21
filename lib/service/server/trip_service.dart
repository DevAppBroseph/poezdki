import 'package:app_poezdka/model/server_responce.dart';
import 'package:app_poezdka/service/local/secure_storage.dart';
import 'package:app_poezdka/src/trips/notification_page.dart';
import 'package:app_poezdka/widget/dialog/info_dialog.dart';
import 'package:app_poezdka/widget/dialog/progress_dialog.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:app_poezdka/export/server_url.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/widget/dialog/error_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class TripService {
  final errorDialog = ErrorDialogs();

  Future<List<TripModel>?> getAllTrips({
    Map? departure,
    Map? destination,
    bool? animals,
    bool? package,
    bool? baggage,
    bool? babyChair,
    bool? smoke,
    bool? twoPlacesInBehind,
    bool? conditioner,
    String? gender,
    int? start,
    int? end,
  }) async {
    String? fcm = await FirebaseMessaging.instance.getToken();
    print('object token fcm ${fcm}');
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
      "conditioner": conditioner,
      "start": start,
      "end": 16755865065000000,
      "fcm_token": fcm
    };

    Response response;
    var dio = Dio();
    final token = await SecureStorage.instance.getToken();

    try {
      final userHeader = {
        "Content-type": "application/json",
        "Accept": "application/json",
        "Authorization": token
      };
      response = await dio.post(
        getAllTripsUrl,
        data: json.encode(filter),
        options: Options(
            headers: userHeader, validateStatus: (status) => status! >= 200),
      );
      if (response.statusCode == 200) {
        final body = response.data;
        final list = body['all_trips'] as List;

        List<TripModel> trips = [];
        list.map((e) {
          trips.add(TripModel.fromJson(e, true));
        }).toList();
        return trips;
      } else {
        // throw Exception('Ошибка сервера. Код ошибки: ${response.statusCode}');
      }
    } catch (e) {
      // errorDialog.showError(e.toString());
      return null;
    }
  }

  Future<List<TripModel>?> getAllDriversTrips(
      {Map? departure,
      Map? destination,
      bool? animals,
      bool? package,
      bool? baggage,
      bool? babyChair,
      bool? smoke,
      bool? twoPlacesInBehind,
      bool? conditioner,
      int? start}) async {
    final filter = {
      if (departure != null) "departure": departure,
      if (destination != null) "destination": destination,
      "animals": animals,
      "package": package,
      "baggage": baggage,
      "baby_chair": babyChair,
      "smoke": smoke,
      "two_places_in_behind": twoPlacesInBehind,
      "conditioner": conditioner,
      "over4seats": null,
      "start": start,
      "end": 16755865065000000,
    };

    Response response;
    var dio = Dio();

    print('object ${filter}');

    try {
      // var response = await http.get(allTrips);
      response =
          await dio.post(getAllDriverTripsUrl, data: json.encode(filter));

      if (response.statusCode == 200) {
        final list = response.data['all_trips'] as List;

        List<TripModel> trips = [];
        list.map((e) {
          trips.add(TripModel.fromJson(e, false));
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

  Future<bool> createTripPassanger({required TripModel trip}) async {
    ProgressDialog().show(title: 'Создание поездки', width: 200, height: 100);
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
              validateStatus: (status) => status! <= 400,
              headers: {"Authorization": token},
              responseType: ResponseType.json));

      SmartDialog.dismiss();
      if (response.statusCode == 200) {
        final responceData = ResponceServerData.fromMap(response.data);
        return responceData.success;
      } else {
        errorDialog.showError(
          'Минимальная стоимость поездки составляет: ${response.toString().split(':')[2].replaceAll(' ', '')} руб.',
        );
        return false;
      }
    } catch (e) {
      errorDialog.showError(e.toString());
      return false;
    }
  }

  Future<bool> createTripDriver(
      {required BuildContext context, required TripModel trip}) async {
    ProgressDialog().show(title: 'Создание поездки', width: 200, height: 100);
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
      "conditioner": trip.conditioner,
      "seats": trip.seats
    };

    final token = await SecureStorage.instance.getToken();

    try {
      // final token = await SecureStorage.instance.getToken();
      response = await dio.post(
        addTripUrl,
        data: json.encode(data),
        options: Options(
          headers: {"Authorization": token},
          responseType: ResponseType.json,
          validateStatus: (status) => status! <= 400,
        ),
      );
      SmartDialog.dismiss();
      if (response.statusCode == 200) {
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
          // return false;
        }
      } else {
        errorDialog.showError(
          'Минимальная стоимость поездки составляет: ${response.toString().split(':')[2].replaceAll(' ', '')} руб.',
        );
        return false;
      }
      return false;
    } catch (e) {
      // InfoDialog().show(
      // img: "assets/img/like.svg",
      //   title: "Внимание!",
      //   description: "Цена по данному направление ниже минимальной.",
      // );
      errorDialog.showError(e.toString());
      // errorDialog.showError(e.toString());
      return false;
    }
  }

  Future<bool> bookTrip(context,
      {required int tripId, required List<int?> seats}) async {
    ProgressDialog().show(title: 'Бронирование', width: 200, height: 100);
    Response response;
    var dio = Dio();
    final data = {
      "seats": seats,
    };
    try {
      final token = await SecureStorage.instance.getToken();
      response = await dio.post(
        "$bookingTripUrl$tripId",
        data: json.encode(data),
        options: Options(
          headers: {"Authorization": token},
          responseType: ResponseType.json,
          validateStatus: (status) => status! <= 400,
        ),
      );
      if (response.statusCode == 400) {
        errorDialog.showError(response.data);
        return false;
      }
      final responceData = ResponceServerData.fromMap(response.data);
      if (responceData.success) {
        await SmartDialog.dismiss();
        InfoDialog().show(
            title: "Ваше место забронировано!",
            img: "assets/img/like.svg",
            description:
                "Желаем вам хорошей поездки. Вы можете отменить свою поездку в разделе Профиль.",
            onPressed: () {
              SmartDialog.dismiss();
              Navigator.pop(context);
              // Navigator.pop(context);
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

  Future<bool> bookPackage(context,
      {required int tripId, required List<int> seats}) async {
    Response response;
    var dio = Dio();
    try {
      final token = await SecureStorage.instance.getToken();
      response = await dio.post(
        "$bookingTripUrl$tripId",
        data: json.encode({}),
        options: Options(
          headers: {"Authorization": token},
          responseType: ResponseType.json,
        ),
      );
      final responceData = ResponceServerData.fromMap(response.data);
      if (responceData.success) {
        InfoDialog().show(
            title: "Место для посылки забронировано!",
            img: "assets/img/like.svg",
            description: "Посылка доедет в целости и сохранности.",
            onPressed: () {
              SmartDialog.dismiss();
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
      final token = await SecureStorage.instance.getToken();
      res = await dio.delete(
        "$cancelBookingTripUrl$tripId",
        options: Options(
          validateStatus: ((status) => status! >= 200),
          headers: {"Authorization": token},
          responseType: ResponseType.json,
        ),
      );
    } catch (e) {
      errorDialog.showError(e.toString());
    }
  }

  Future<void> cancelPassengerInTrip(
      {required int tripId, required int userId}) async {
    Response res;
    var dio = Dio();

    try {
      final token = await SecureStorage.instance.getToken();
      res = await dio.delete(
        cancelPassengerTripUrl,
        data: {'trip_id': tripId, 'user_id': userId},
        options: Options(
          validateStatus: ((status) => status! >= 200),
          headers: {"Authorization": token},
          responseType: ResponseType.json,
        ),
      );
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
          headers: {"Authorization": token},
          responseType: ResponseType.json,
          validateStatus: (status) => status! >= 200);

      responses = await Future.wait([
        dio.get(getDriverTripsUrl, options: options),
        dio.get(getDriverPastTripsUrl, options: options),
      ]);
      return [
        _getTripsFromRequest(responses[0], false),
        _getTripsFromRequest(responses[1], false),
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
        _getTripsFromRequest(responses[0], true),
        _getTripsFromRequest(responses[1], true),
      ];
    } catch (e) {
      return [];
    }
  }

  List<TripModel> _getTripsFromRequest(Response response, bool passenger) {
    return [
      if (response.statusCode == 200)
        for (var i in response.data['trips']) TripModel.fromJson(i, passenger),
    ];
  }

  Future<void> deleteTrip(int tripId) async {
    final dio = Dio();
    try {
      final token = await SecureStorage.instance.getToken();
      final options = Options(
          headers: {"Authorization": token},
          responseType: ResponseType.json,
          validateStatus: (status) => status! >= 200);
      var result = await dio.delete("$deleteTripUrl$tripId", options: options);
    } catch (e) {}
  }

  Future<void> addReview(int id, String message, int mark) async {
    final dio = Dio();
    try {
      final token = await SecureStorage.instance.getToken();
      final options = Options(
          headers: {"Authorization": token},
          responseType: ResponseType.json,
          validateStatus: (status) => status! >= 200);
      var result = await dio.post(
        "$serverURL/users/review$id",
        options: options,
        data: jsonEncode(
          {
            "message": message,
            "mark": mark,
          },
        ),
      );
    } catch (e) {}
  }

  Future<dynamic> checkTripOrder(int id) async {
    final dio = Dio();
    try {
      final token = await SecureStorage.instance.getToken();
      final options = Options(
          headers: {"Authorization": token},
          responseType: ResponseType.json,
          validateStatus: (status) => status! <= 400);
      var result = await dio.post(
        "$serverURL/booking/check$id",
        options: options,
      );
      if (result.statusCode == 200) {
        return result.data['valid'];
      }
      if (result.statusCode == 400) {
        return result.data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> checkMinPrice(
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
      "conditioner": trip.conditioner,
      "seats": trip.seats
    };

    final token = await SecureStorage.instance.getToken();

    try {
      response = await dio.post(
        checkTripUrl,
        data: json.encode(data),
        options: Options(
          headers: {"Authorization": token},
          responseType: ResponseType.json,
          validateStatus: (status) => status! <= 400,
        ),
      );
      if (response.statusCode == 200) {
        return true;
      }
      if (response.statusCode == 400) {
        errorDialog.showError(
          'Внимание: по данному направлению установлена минимальная стоимость: ${response.toString().split(':')[2].replaceAll(' ', '')} руб.',
        );
        return false;
      }
      return false;
    } catch (e) {
      errorDialog.showError(e.toString());
      print('object response $token object log 3 ${e}');
      return false;
    }
  }

  Future<bool> setNotification(String startWay, String endWay,
      int timeMilisecondStart, int timeMilisecondEnd) async {
    final body = {
      "departure": {"name": startWay},
      "destination": {"name": endWay},
      "time_from": timeMilisecondStart,
      "time_to": timeMilisecondEnd
    };

    Response response;
    var dio = Dio();
    final token = await SecureStorage.instance.getToken();

    try {
      response = await dio.post(
        'http://194.87.145.140/trips/add_trip_not',
        data: json.encode(body),
        options: Options(
          headers: {"Authorization": token},
        ),
      );

      if (response.statusCode == 200) return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<List<NotificationModel>?> allNotification() async {
    Response response;
    var dio = Dio();
    final token = await SecureStorage.instance.getToken();

    try {
      response = await dio.get(
        'http://194.87.145.140/trips/get_trip_nots',
        options: Options(
          headers: {"Authorization": token},
        ),
      );

      List<NotificationModel> notifModel = [];

      if (response.statusCode == 200) {
        for (var element in response.data) {
          notifModel.add(NotificationModel.fromJson(element));
        }
        return notifModel;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteNotif(int id) async {
    Response response;
    var dio = Dio();
    final token = await SecureStorage.instance.getToken();

    try {
      response = await dio.delete(
        'http://194.87.145.140/trips/del$id',
        options: Options(
            headers: {"Authorization": token},
            validateStatus: (status) => status! <= 400),
      );

      // print('object catch ${response}');

      if (response.statusCode == 200) return true;

      return false;
    } catch (e) {
      return false;
    }
  }
}
