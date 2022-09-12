class PassengerModel {
  int? id;
  String? phone;
  String? phone_number;
  String? photo;
  String? firstname;
  String? lastname;
  List<int>? seat;
  PassengerModel(
      {this.id, this.phone, this.phone_number, this.firstname, this.lastname, this.seat});

  PassengerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    phone_number = json['phone_number'];
    photo = json['photo'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    seat = json['seat'].cast<int>();
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
