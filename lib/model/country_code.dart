class CountryCode {
  CountryCode({
    required this.country,
  });
  final List<Country> country;

  factory CountryCode.fromJson(Map<String, dynamic> json) {
    final country =
        List.from(json['country']).map((e) => Country.fromJson(e)).toList();
    return CountryCode(country: country);
  }
}

class Country {
  Country({
    required this.name,
    required this.dialCode,
    required this.code,
    required this.lengthPhone,
  });
  final String? name;
  final String? dialCode;
  final String? code;
  final String? lengthPhone;

  factory Country.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final dialCode = json['dial_code'];
    final code = json['code'];
    final lengthPhone = json['length_phone'];
    return Country(
      name: name,
      dialCode: dialCode,
      code: code,
      lengthPhone: lengthPhone,
    );
  }
}
