class ReviewModel {
  double? average;
  List<Reviews>? reviews;

  ReviewModel({this.average, this.reviews});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    average = json['average'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['average'] = average;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reviews {
  From? from;
  String? message;
  int? mark;
  String? date;

  Reviews({this.from, this.message, this.mark, this.date});

  Reviews.fromJson(Map<String, dynamic> json) {
    from = json['from'] != null ? From.fromJson(json['from']) : null;
    message = json['message'];
    mark = json['mark'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (from != null) {
      data['from'] = from!.toJson();
    }
    data['message'] = message;
    data['mark'] = mark;
    data['date'] = date;
    return data;
  }
}

class From {
  int? id;
  String? photo;
  String? firstname;
  String? lastname;

  From({this.id, this.photo, this.firstname, this.lastname});

  From.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['photo'] = photo;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    return data;
  }
}
