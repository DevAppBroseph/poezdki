import 'package:app_poezdka/model/passenger_model.dart';

class TripModel {
  bool? isPremium;
  int? tripId;
  Owner? owner;
  Car? car;
  int? price;
  int? timeStart;
  Departure? departure;
  List<Stops>? stops;
  bool? package;
  bool? baggage;
  bool? babyChair;
  bool? smoke;
  bool? animals;
  bool? twoPlacesInBehind;
  List<PassengerModel>? passengers;
  bool? conditioner;
  String? ownerGender;

  TripModel(
      {this.isPremium,
      this.tripId,
      this.owner,
      this.car,
      this.price,
      this.timeStart,
      this.departure,
      this.stops,
      this.package,
      this.baggage,
      this.babyChair,
      this.smoke,
      this.animals,
      this.twoPlacesInBehind,
      this.passengers,
      this.conditioner,
      this.ownerGender});

  TripModel.fromJson(Map<String, dynamic> json) {
    isPremium = json['is_premium'];
    tripId = json['trip_id'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    car = json['car'] != null ? Car.fromJson(json['car']) : null;
    price = json['price'];
    timeStart = json['time_start'];
    departure = json['departure'] != null
        ? Departure.fromJson(json['departure'])
        : null;
    if (json['stops'] != null) {
      stops = <Stops>[];
      json['stops'].forEach((v) {
        stops!.add(Stops.fromJson(v));
      });
    }
    package = json['package'];
    baggage = json['baggage'];
    babyChair = json['baby_chair'];
    smoke = json['smoke'];
    animals = json['animals'];
    twoPlacesInBehind = json['two_places_in_behind'];
    if (json['passengers'] != null) {
      passengers = <PassengerModel>[];
      json['passengers'].forEach((v) {
        passengers!.add(PassengerModel.fromJson(v));
      });
    }
    conditioner = json['conditioner'];
    ownerGender = json['owner_gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trip_id'] = tripId;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    if (car != null) {
      data['car'] = car!.toJson();
    }
    data['price'] = price;
    data['time_start'] = timeStart;
    if (departure != null) {
      data['departure'] = departure!.toJson();
    }
    if (stops != null) {
      data['stops'] = stops!.map((v) => v.toJson()).toList();
    }
    data['package'] = package;
    data['baggage'] = baggage;
    data['baby_chair'] = babyChair;
    data['smoke'] = smoke;
    data['animals'] = animals;
    data['two_places_in_behind'] = twoPlacesInBehind;
    if (passengers != null) {
      data['passengers'] = passengers!.map((v) => v.toJson()).toList();
    }
    data['conditioner'] = conditioner;
    data['owner_gender'] = ownerGender;
    return data;
  }
}

class Owner {
  int? id;
  String? phone;
  String? firstname;
  String? lastname;
  String? photo;
  String? seat;

  Owner(
      {this.id,
      this.phone,
      this.firstname,
      this.lastname,
      this.photo,
      this.seat});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    photo = json['photo'];
    seat = json['seat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phone'] = phone;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    return data;
  }
}

class Car {
  int? pk;
  int? owner;
  String? mark;
  String? model;
  String? color;
  String? vehicleNumber;
  int? countOfPassengers;

  Car(
      {this.pk,
      this.owner,
      this.mark,
      this.model,
      this.color,
      this.vehicleNumber,
      this.countOfPassengers});

  Car.fromJson(Map<String, dynamic> json) {
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

class Departure {
  Coords? coords;
  String? district;
  String? name;
  int? population;
  String? subject;

  Departure(
      {this.coords, this.district, this.name, this.population, this.subject});

  Departure.fromJson(Map<String, dynamic> json) {
    coords = json['coords'] != null ? Coords.fromJson(json['coords']) : null;
    district = json['district'];
    name = json['name'];
    population = json['population'];
    subject = json['subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (coords != null) {
      data['coords'] = coords!.toJson();
    }
    data['district'] = district;
    data['name'] = name;
    data['population'] = population;
    data['subject'] = subject;
    return data;
  }
}

class Coords {
  double? lat;
  double? lon;

  Coords({this.lat, this.lon});

  Coords.fromJson(Map<String, dynamic> json) {
    lat = double.tryParse(json['lat'].toString());
    lon = double.tryParse(json['lon'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    return data;
  }
}

class Stops {
  Coords? coords;
  String? district;
  String? name;
  int? population;
  String? subject;
  double? approachTime;
  int? distanceToPrevious;

  Stops(this.coords, this.district, this.name, this.population, this.subject,
      this.approachTime, this.distanceToPrevious);

  Stops.fromJson(Map<String, dynamic> json) {
    coords = json['coords'] != null ? Coords.fromJson(json['coords']) : null;
    district = json['district'];
    name = json['name'];
    population = json['population'];
    subject = json['subject'];
    approachTime = (json['approach_time'] as int).toDouble();
    distanceToPrevious = json['distance_to_previous'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (coords != null) {
      data['coords'] = coords!.toJson();
    }
    data['district'] = district;
    data['name'] = name;
    data['population'] = population;
    data['subject'] = subject;
    data['time'] = approachTime;
    data['distance_to_previous'] = distanceToPrevious;
    return data;
  }

  Stops copyWith({
    Coords? coords,
    String? district,
    String? name,
    int? population,
    String? subject,
    double? approachTime,
    int? distanceToPrevious,
  }) {
    return Stops(
      coords ?? this.coords,
      district ?? this.district,
      name ?? this.name,
      population ?? this.population,
      subject ?? this.subject,
      approachTime ?? this.approachTime,
      distanceToPrevious ?? this.distanceToPrevious,
    );
  }
}
