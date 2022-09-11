import 'dart:convert';

Rating ratingFromJson(String str) => Rating.fromJson(json.decode(str));

String ratingToJson(Rating data) => json.encode(data.toJson());

class Rating {
    Rating({required this.kmSum, required this.level});

    int kmSum;
    int level;

    factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        kmSum: json["km_sum"],
        level: json["level"],
    );

    Map<String, dynamic> toJson() => {
        "km_sum": kmSum,
        "level": level,
    };
}
