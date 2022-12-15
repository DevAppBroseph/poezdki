// To parse this JSON data, do
//
//     final messagesAnswer = messagesAnswerFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

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
    required this.time,
  });

  int from;
  int to;
  String message;
  DateTime time;

  factory MessagesAnswer.fromJson(Map<String, dynamic> json)  {
    return MessagesAnswer(
        from: json["from"],
        to: json["to"],
        message: json["message"],
        time: DateFormat("yyyy-MM-ddThh:mm:ss").parse(json["time"], true).toLocal()
      );}

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "message": message,
      };
}
