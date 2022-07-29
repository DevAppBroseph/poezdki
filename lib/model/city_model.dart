import 'dart:convert';

class City {
  Coords? coords;
  String? district;
  String? name;
  int? population;
  String? subject;

  City({this.coords, this.district, this.name, this.population, this.subject});

 

  Map<String, dynamic> toMap() {
    return {
      'coords': coords?.toMap(),
      'district': district,
      'name': name,
      'population': population,
      'subject': subject,
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      coords: map['coords'] != null ? Coords.fromMap(map['coords']) : null,
      district: map['district'],
      name: map['name'],
      population: map['population']?.toInt(),
      subject: map['subject'],
    );
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(String source) => City.fromMap(json.decode(source));
}

class Coords {
  String? lat;
  String? lon;

  Coords({this.lat, this.lon});

 

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lon': lon,
    };
  }

  factory Coords.fromMap(Map<String, dynamic> map) {
    return Coords(
      lat: map['lat'],
      lon: map['lon'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Coords.fromJson(String source) => Coords.fromMap(json.decode(source));
}
