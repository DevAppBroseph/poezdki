import 'package:app_poezdka/model/trip_model.dart';

class ModelSearch {
  int? page;
  Departure? departure;
  Departure? destination;
  bool animals;
  bool package;
  bool baggage;
  bool babyChair;
  bool smoke;
  bool twoPlacesInBehind;
  bool conditioner;
  String? gender;
  int? start;
  int? end;

  ModelSearch({
    required this.page,
    required this.departure,
    required this.destination,
    required this.animals,
    required this.package,
    required this.baggage,
    required this.babyChair,
    required this.smoke,
    required this.twoPlacesInBehind,
    required this.conditioner,
    required this.gender,
    required this.start,
    required this.end,
  });

  factory ModelSearch.fromJson(Map<String, dynamic> json) {
    return ModelSearch(
      page: json['page'],
      departure: Departure.fromJson(json['departure']),
      destination: Departure.fromJson(json['destination']),
      animals: json['animals'],
      package: json['package'],
      baggage: json['baggage'],
      babyChair: json['babyChair'],
      smoke: json['smoke'],
      twoPlacesInBehind: json['twoPlacesInBehind'],
      conditioner: json['conditioner'],
      gender: json['gender'],
      start: json['start'],
      end: json['end'],
    );
  }
}