import 'package:intl/intl.dart';

class AnswerSupport {
  String? text;
  DateTime? datetime;
  String? answer;
  DateTime? answerDatetime;

  AnswerSupport({
    this.text,
    this.datetime,
    this.answer,
    this.answerDatetime,
  });

  AnswerSupport.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    datetime = DateFormat("yyyy-MM-ddThh:mm:ss").parse(json["datetime"], true);
    answer = json['answer'];
    answerDatetime = json["answer_datetime"] != null
        ? DateFormat("yyyy-MM-ddThh:mm:ss").parse(json["answer_datetime"], true)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['datetime'] = datetime;
    data['answer'] = answer;
    data['answer_datetime'] = answerDatetime;
    return data;
  }
}
