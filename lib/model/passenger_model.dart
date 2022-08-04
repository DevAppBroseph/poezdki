class PassengerModel {
  String? phone;
  String? firstname;
  String? lastname;

  PassengerModel({this.phone, this.firstname, this.lastname});

  PassengerModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = phone;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    return data;
  }
}