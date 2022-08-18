// To parse this JSON data, do
//
//     final messagesAnswer = messagesAnswerFromJson(jsonString);

import 'dart:convert';

List<MessagesAnswer> messagesAnswerFromJson(String str) =>
    List<MessagesAnswer>.from(
        json.decode(str).map((x) => MessagesAnswer.fromJson(x)));

String messagesAnswerToJson(List<MessagesAnswer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessagesAnswer {
  MessagesAnswer({
    required this.from,
    required this.to,
    required this.message,
  });

  int from;
  int to;
  String message;

  factory MessagesAnswer.fromJson(Map<String, dynamic> json) => MessagesAnswer(
        from: json["from"],
        to: json["to"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "message": message,
      };
}
