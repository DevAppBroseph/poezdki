import 'package:app_poezdka/model/trip_model.dart';

class PassengerModel {
  int? id;
  String? phone;
  String? phoneNumber;
  String? photo;
  String? firstname;
  String? lastname;
  List<int>? seat;
  Reviews? reviews;
  PassengerModel(
      {this.id,
      this.phone,
      this.phoneNumber,
      this.firstname,
      this.lastname,
      this.seat,
      this.reviews});

  PassengerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    phoneNumber = json['phone_number'];
    photo = json['photo'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    seat = json['seat'].cast<int>();
    reviews = Reviews.fromJson(json['reviews']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phone'] = phone;
    data['photo'] = photo;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['seat'] = seat;
    return data;
  }
}
