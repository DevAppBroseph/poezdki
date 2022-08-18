// To parse this JSON data, do
//
//     final sendMessage = sendMessageFromJson(jsonString);

import 'dart:convert';

SendMessage sendMessageFromJson(String str) =>
    SendMessage.fromJson(json.decode(str));

String sendMessageToJson(SendMessage data) => json.encode(data.toJson());

class SendMessage {
  SendMessage({
    required this.from,
    required this.message,
  });

  int from;
  String message;

  factory SendMessage.fromJson(Map<String, dynamic> json) => SendMessage(
        from: json["from"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "to": from,
        "message": message,
      };
}
