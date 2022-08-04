import 'dart:convert';

class CityStop {
  Coords? coords;
  String? district;
  String? name;
  int? population;
  String? subject;
  int? approachTime;

  CityStop(
      {this.coords, this.district, this.name, this.population, this.subject, this.approachTime});

  Map<String, dynamic> toMap() {
    return {
      'coords': coords?.toMap(),
      'district': district,
      'name': name,
      'population': population,
      'subject': subject,
      'approach_time': approachTime
    };
  }

  factory CityStop.fromMap(Map<String, dynamic> map) {
    return CityStop(
      coords: map['coords'] != null ? Coords.fromMap(map['coords']) : null,
      district: map['district'],
      name: map['name'],
      population: map['population']?.toInt(),
      subject: map['subject'],
      approachTime: map['approach_time']
    );
  }

  String toJson() => json.encode(toMap());

  factory CityStop.fromJson(String source) =>
      CityStop.fromMap(json.decode(source));
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
