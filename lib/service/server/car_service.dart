import 'dart:convert';

import 'package:app_poezdka/model/car_model.dart';
import 'package:http/http.dart' as http;

import 'package:app_poezdka/export/server_url.dart';

import '../../export/services.dart';
import '../../widget/dialog/error_dialog.dart';

class CarService {
  final userRepo = SecureStorage.instance;
  final errorDialog = ErrorDialogs();
  static var uriGetCars = Uri.parse(getCarsUrl);
  static var uriAddCar = Uri.parse(addCarUrl);
  static var uriDeleteCar = Uri.parse(deleteCarUrl);

  Future<bool> addCar({
    required String token,
    required CarModel car,
  }) async {
    try {
      var body = json.encode(car.toMap());
      var response = await http.post(uriAddCar,
          headers: {"Authorization": token}, body: body);
      if (response.statusCode == 200) {
        final responce = CarResponce.fromJson(response.body);
        return responce.success!;
      } else {
        throw Exception('Ошибка при добавлении автомобиля!');
      }
    } catch (e) {
      errorDialog.showError(e.toString());
      return false;
    }
  }

  Future<bool> deleteCar({
    required String token,
    required int carId,
  }) async {
    try {
      var response = await http.delete(
        Uri.parse("$deleteCarUrl$carId"),
        headers: {"Authorization": token},
      );
      if (response.statusCode == 200) {
        final carResponce = CarResponce.fromJson(response.body);
        return carResponce.success!;
      } else {
        throw Exception('Ошибка при удаления автомобиля!');
      }
    } catch (e) {
      errorDialog.showError(e.toString());
      return false;
    }
  }

  Future<List<CarModel>> getUserCars() async {
    try {
      final token = await userRepo.getToken();
      var response = await http.get(
        uriGetCars,
        headers: {"Authorization": token!},
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        final list = data['cars'] as List;
        List<CarModel> cars = [];
        list.map((e) => cars.add(CarModel.fromMap(e))).toList();

        return cars;
      } else {
        throw Exception('Ошибка при загрузке списка автомобилей!');
      }
    } catch (e) {
      errorDialog.showError(e.toString());
      return [];
    }
  }
}

class CarResponce {
  bool? success;
  String? status;

  CarResponce({this.success, this.status});

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'status': status,
    };
  }

  factory CarResponce.fromMap(Map<String, dynamic> map) {
    return CarResponce(
      success: map['success'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CarResponce.fromJson(String source) =>
      CarResponce.fromMap(json.decode(source));
}
