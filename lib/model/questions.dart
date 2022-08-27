import 'dart:convert';

QuestionsAnswer questionsAnswerFromJson(String str) =>
    QuestionsAnswer.fromJson(json.decode(str));

String questionsAnswerToJson(QuestionsAnswer data) =>
    json.encode(data.toJson());

class QuestionsAnswer {
  QuestionsAnswer({
    required this.questions,
  });

  List<Question> questions;

  factory QuestionsAnswer.fromJson(Map<String, dynamic> json) =>
      QuestionsAnswer(
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  Question({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });

  String question;
  String answer;
  bool isExpanded;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json["question"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
      };
}
