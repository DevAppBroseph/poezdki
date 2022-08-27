import 'dart:convert';

ResetPasswordOne resetPasswordOneFromJson(String str) =>
    ResetPasswordOne.fromJson(json.decode(str));

String resetPasswordOneToJson(ResetPasswordOne data) =>
    json.encode(data.toJson());

class ResetPasswordOne {
  ResetPasswordOne({
    required this.type,
    required this.login,
  });

  String type;
  String login;

  factory ResetPasswordOne.fromJson(Map<String, dynamic> json) =>
      ResetPasswordOne(
        type: json["type"],
        login: json["login"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "login": login,
      };
}
