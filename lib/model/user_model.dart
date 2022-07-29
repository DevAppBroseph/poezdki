// import 'dart:convert';

// class UserModel {
//   final String token;
//   final String login;
//   final String firstname;
//   final String lastname;
//   final String gender;
//   final int birth;
//   final List<Cars> cars;

//   UserModel(
//       {required this.token,
//       required this.login,
//       required this.firstname,
//       required this.lastname,
//       required this.gender,
//       required this.birth,
//       required this.cars});

//   Map<String, dynamic> toMap() {
//     return {
//       'token': token,
//       'login': login,
//       'firstname': firstname,
//       'lastname': lastname,
//       'gender': gender,
//       'birth': birth,
//       'cars': cars.map((x) => x.toJson()).toList(),
//     };
//   }

//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       token: map['token'] ?? '',
//       login: map['login'] ?? '',
//       firstname: map['firstname'] ?? '',
//       lastname: map['lastname'] ?? '',
//       gender: map['gender'] ?? '',
//       birth: map['birth']?.toInt() ?? 0,
//       cars: List<Cars>.from(map['cars']?.map((x) => Cars.fromJson(x))),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory UserModel.fromJson(String source) =>
//       UserModel.fromMap(json.decode(source));
// }

// class Cars {
//   final int pk;
//   final int owner;
//   final String mark;
//   final String model;
//   final String color;
//   final String vehicleNumber;
//   final int countOfPassengers;

//   Cars(
//       {required this.pk,
//       required this.owner,
//       required this.mark,
//       required this.model,
//       required this.color,
//       required this.vehicleNumber,
//       required this.countOfPassengers});

//   Map<String, dynamic> toMap() {
//     return {
//       'pk': pk,
//       'owner': owner,
//       'mark': mark,
//       'model': model,
//       'color': color,
//       'vehicleNumber': vehicleNumber,
//       'countOfPassengers': countOfPassengers,
//     };
//   }

//   factory Cars.fromMap(Map<String, dynamic> map) {
//     return Cars(
//       pk: map['pk']?.toInt() ?? 0,
//       owner: map['owner']?.toInt() ?? 0,
//       mark: map['mark'] ?? '',
//       model: map['model'] ?? '',
//       color: map['color'] ?? '',
//       vehicleNumber: map['vehicleNumber'] ?? '',
//       countOfPassengers: map['countOfPassengers']?.toInt() ?? 0,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Cars.fromJson(String source) => Cars.fromMap(json.decode(source));
// }


class UserModel {
  String? token;
  String? login;
  String? firstname;
  String? lastname;
  String? gender;
  int? birth;
  List<Cars>? cars;

  UserModel(
      {this.token,
      this.login,
      this.firstname,
      this.lastname,
      this.gender,
      this.birth,
      this.cars});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    login = json['login'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    gender = json['gender'];
    birth = json['birth'];
    if (json['cars'] != null) {
      cars = <Cars>[];
      json['cars'].forEach((v) {
        cars!.add(Cars.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['login'] = login;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['gender'] = gender;
    data['birth'] = birth;
    if (cars != null) {
      data['cars'] = cars!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cars {
  int? pk;
  int? owner;
  String? mark;
  String? model;
  String? color;
  String? vehicleNumber;
  int? countOfPassengers;

  Cars(
      {this.pk,
      this.owner,
      this.mark,
      this.model,
      this.color,
      this.vehicleNumber,
      this.countOfPassengers});

  Cars.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    owner = json['owner'];
    mark = json['mark'];
    model = json['model'];
    color = json['color'];
    vehicleNumber = json['vehicle_number'];
    countOfPassengers = json['count_of_passengers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pk'] = pk;
    data['owner'] = owner;
    data['mark'] = mark;
    data['model'] = model;
    data['color'] = color;
    data['vehicle_number'] = vehicleNumber;
    data['count_of_passengers'] = countOfPassengers;
    return data;
  }
}