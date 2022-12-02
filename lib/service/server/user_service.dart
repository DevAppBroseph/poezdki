import 'package:app_poezdka/model/blog.dart';
import 'package:app_poezdka/model/questions.dart';
import 'package:app_poezdka/model/rating.dart';
import 'package:app_poezdka/model/user_model.dart';
import 'package:dio/dio.dart';
import '../../widget/dialog/error_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_poezdka/export/server_url.dart';

class UserService {
  final errorDialog = ErrorDialogs();
  static var getCurrentUserUrl = Uri.parse(currentUser);
  static var getQuestionsUrl = Uri.parse(getQuestionUrl);
  static var getBlogUrl = Uri.parse(getBlogsUrl);
  static var changeUserPhotoUrl = Uri.parse(changePhoto);

  Future<UserModel?> getCurrentUser({required String token}) async {
    // try {
    var response = await http.get(
      getCurrentUserUrl,
      headers: {"Authorization": token},
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      print('object ${body}');
      final UserModel user = UserModel.fromJson(body);
      return user;
    } else {
      throw Exception('Ошибка авторизации, попробуйте еще раз, позже.');
    }
    // } catch (e) {
    //   errorDialog.showError(e.toString());
    //   return null;
    // }
  }

  Future<List<Question>?> getQuestions() async {
    // try {
    var response = await http.get(
      getQuestionsUrl,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      final QuestionsAnswer user = QuestionsAnswer.fromJson(body);
      return user.questions;
    } else {
      throw Exception('Ошибка авторизации, попробуйте еще раз, позже.');
    }
    // } catch (e) {
    //   errorDialog.showError(e.toString());
    //   return null;
    // }
  }

  Future<List<Blog>?> getBlog() async {
    // try {
    var response = await http.get(
      getBlogUrl,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      final BlogAnswer blog = BlogAnswer.fromJson(body);
      return blog.blog;
    } else {
      throw Exception('Ошибка авторизации, попробуйте еще раз, позже.');
    }
    // } catch (e) {
    //   errorDialog.showError(e.toString());
    //   return null;
    // }
  }

  Future<UserModel?> editUser(
      {required String token, required UserModel user}) async {
    // try {
    Response res;
    var dio = Dio();

    // try {
    res = await dio.put(
      "http://194.87.145.140/users/update_user",
      options: Options(
        validateStatus: ((status) => status! == 200),
        headers: {"Authorization": token},
      ),
      data: user.toJson(),
    );
    return UserModel.fromJson(res.data);
  }

  Future<UserModel?> changeUserPhoto(
      {required String token, required String image}) async {
    try {
      var response = await http.put(
        changeUserPhotoUrl,
        headers: {"Authorization": token},
        body: jsonEncode(
          {
            'photo': image,
          },
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        final UserModel user = UserModel.fromJson(body);
        return user;
      } else {
        throw Exception('Ошибка авторизации, попробуйте еще раз, позже.');
      }
    } catch (e) {
      errorDialog.showError(e.toString());
      return null;
    }
  }

  Future<Rating?> getRatingUser({required String token}) async {
    try {
      var response = await http.get(Uri.parse(rating), headers: {"Authorization": token});

      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        return Rating.fromJson(body);
      }
    } catch (e) {
      errorDialog.showError(e.toString());
      return null;
    }
    return null;
  }

  Future<String?> getInfo() async {
    try {
      var response = await http.get(Uri.parse(info));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return json['info']['text'];
      }
    } catch (e) {
      errorDialog.showError(e.toString());
      return null;
    }
    return null;
  }

  Future<String?> getOffer() async {
    try {
      var response = await http.get(Uri.parse(offer));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return json['info']['text'];
      }
    } catch (e) {
      errorDialog.showError(e.toString());
      return null;
    }
    return null;
  }

  Future<String?> getPolitic() async {
    try {
      var response = await http.get(Uri.parse(politic));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return json['info']['text'];
      }
    } catch (e) {
      errorDialog.showError(e.toString());
      return null;
    }
    return null;
  }
}
