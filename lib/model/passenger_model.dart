class PassengerModel {
  int? id;
  String? phone;
  String? firstname;
  String? lastname;

  PassengerModel({this.id, this.phone, this.firstname, this.lastname});

  PassengerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = phone;
    data['phone'] = phone;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    return data;
  }
}
