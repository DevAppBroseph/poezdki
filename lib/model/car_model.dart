import 'dart:convert';

class CarModel {
  final int? pk;
  final int? owner;
  final String mark;
  final String model;
  final String color;
  final String vehicleNumber;
  final int countOfPassengers;
  CarModel({
    this.pk,
    this.owner,
    required this.mark,
    required this.model,
    required this.color,
    required this.vehicleNumber,
    required this.countOfPassengers,
  });

  Map<String, dynamic> toMap() {
    return {
      'pk': pk,
      'owner': owner,
      'mark': mark,
      'model': model,
      'color': color,
      'vehicle_number': vehicleNumber,
      'count_of_passengers': countOfPassengers,
    };
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      pk: map['pk'] ?? '',
      owner: map['owner'] ?? '',
      mark: map['mark'] ?? '',
      model: map['model'] ?? '',
      color: map['color'] ?? '',
      vehicleNumber: map['vehicle_number'] ?? '',
      countOfPassengers: map['count_of_passengers']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarModel.fromJson(String source) =>
      CarModel.fromMap(json.decode(source));

  
}
