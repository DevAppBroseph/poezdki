class AnswerSupport {
  String? text;
  String? datetime;
  String? answer;
  String? answerDatetime;

  AnswerSupport({
    this.text,
    this.datetime,
    this.answer,
    this.answerDatetime,
  });

  AnswerSupport.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    datetime = json['datetime'];
    answer = json['answer'];
    answerDatetime = json['answer_datetime'];
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
