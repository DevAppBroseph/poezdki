import 'package:app_poezdka/model/passenger_model.dart';
import 'package:intl/intl.dart';

class TripModel {
  bool? passenger;
  bool? isPremium;
  int? tripId;
  Owner? owner;
  Car? car;
  int? price;
  int? maxSeats;
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
  List<int>? seats = [];
  int? bronSeat;

  TripModel(
      {this.passenger = false,
      this.isPremium,
      this.tripId,
      this.owner,
      this.car,
      this.price,
      this.maxSeats,
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
      this.ownerGender,
      this.seats = const [],
      this.bronSeat});

  TripModel.fromJson(Map<String, dynamic> json, bool state) {
    passenger = state;
    bronSeat = json['over4index'];
    isPremium = json['premium'];
    tripId = json['trip_id'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    car = json['car'] != null ? Car.fromJson(json['car']) : null;
    price = json['price'];
    // maxSeats = json['max_seats'];
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
  String? phoneNumber;
  String? firstname;
  String? lastname;
  String? photo;
  String? seat;
  Reviews? reviews;

  Owner(
      {this.id,
      this.phone,
      this.phoneNumber,
      this.firstname,
      this.lastname,
      this.photo,
      this.seat,
      this.reviews});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    phoneNumber = json['phone_number'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    photo = json['photo'];
    seat = json['seat'];
    reviews = Reviews.fromJson(json['reviews']);
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

class Reviews {
  dynamic average;
  List<ReviewsItems> items = [];

  Reviews(this.average, this.items);

  Reviews.fromJson(Map<String, dynamic> json) {
    average = json['average'];
    if (json['reviews'] != null) {
      for (var element in json['reviews']) {
        items.add(ReviewsItems.fromJson(element));
      }
    }
  }
}

class ReviewsItems {
  String? message;
  dynamic mark;
  DateTime? date;
  From? from;

  ReviewsItems(this.message, this.mark, this.date, this.from);

  ReviewsItems.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    mark = json['mark'];
    date = json["date"] != null
        ? DateFormat("yyyy-MM-ddThh:mm:ss").parse(json["date"], true).toLocal()
        : null;
    from = From.fromJson(json['from']);
  }
}

class From {
  int? id;
  String? photo;
  String? firstname;
  String? lastname;

  From(this.id, this.photo, this.firstname, this.lastname);

  From.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    firstname = json['firstname'];
    lastname = json['lastname'];
  }
}
