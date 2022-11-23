class VKModel {
  VKModel({
    required this.id,
    required this.token,
    required this.login,
    required this.email,
     this.phoneNumber,
     this.photo,
    required this.firstname,
    required this.lastname,
     this.gender,
     this.birth,
    required this.cars,
  });
  late final int id;
  late final String token;
  late final String login;
  late final String? email;
  late final String? phoneNumber;
  late final String? photo;
  late final String firstname;
  late final String lastname;
  late final String? gender;
  late final String? birth;
  late final List<dynamic> cars;
  
  VKModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    token = json['token'];
    login = json['login'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    photo = json['photo'];;
    firstname = json['firstname'];
    lastname = json['lastname'];
    gender = json['gender'];;
    birth = json['birth'];;
    cars = List.castFrom<dynamic, dynamic>(json['cars']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['token'] = token;
    _data['login'] = login;
    _data['email'] = email;
    _data['phone_number'] = phoneNumber;
    _data['photo'] = photo;
    _data['firstname'] = firstname;
    _data['lastname'] = lastname;
    _data['gender'] = gender;
    _data['birth'] = birth;
    _data['cars'] = cars;
    return _data;
  }
}