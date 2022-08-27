import 'dart:convert';

BlogAnswer blogAnswerFromJson(String str) =>
    BlogAnswer.fromJson(json.decode(str));

String blogAnswerToJson(BlogAnswer data) => json.encode(data.toJson());

class BlogAnswer {
  BlogAnswer({
    required this.blog,
  });

  List<Blog> blog;

  factory BlogAnswer.fromJson(Map<String, dynamic> json) => BlogAnswer(
        blog: List<Blog>.from(json["blog"].map((x) => Blog.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "blog": List<dynamic>.from(blog.map((x) => x.toJson())),
      };
}

class Blog {
  Blog({
    required this.image,
    required this.header,
    required this.text,
  });

  String image;
  String header;
  String text;

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        image: json["image"],
        header: json["header"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "header": header,
        "text": text,
      };
}
