import 'dart:convert';

IsCorrect isCorrectFromJson(String str) => IsCorrect.fromJson(json.decode(str));

String isCorrectToJson(IsCorrect data) => json.encode(data.toJson());

class IsCorrect {
  IsCorrect({
    required this.isCorrect,
    required this.token,
  });

  bool isCorrect;
  String token;

  factory IsCorrect.fromJson(Map<String, dynamic> json) => IsCorrect(
        isCorrect: json["is_correct"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "is_correct": isCorrect,
        "token": token,
      };
}
