import 'dart:convert';
import 'package:app_poezdka/export/server_url.dart';

import 'package:app_poezdka/widget/dialog/error_dialog.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final errorDialog = ErrorDialogs();
  static var signUpUrl = Uri.parse(regUrl);
  static var signInUrl = Uri.parse(authUrl);

  Future<String?> signUp(
      {required String login,
      required String password,
      required String firstName,
      required String lastName,
      required String gender,
      required int birth}) async {
    Map<String, dynamic> params = {
      "login": login,
      "password": password,
      "firstname": firstName,
      "lastname": lastName,
      "gender": gender,
      "birth": "$birth"
    };

    try {
      var body = json.encode(params);
      var response = await http.post(signUpUrl,
          headers: {"Accept": "application/json"}, body: body);
      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        final String token = body['token'];
        return token;
      } else {
        return throw Exception(
            'Ошибка авторизации, попробуйте еще раз, позже.');
      }
    } catch (e) {
      errorDialog.showError(e.toString());
      return null;
    }
  }

  Future<String?> signIn({
    required String login,
    required String password,
  }) async {
    Map<String, dynamic> params = {
      "login": login,
      "password": password,
    };

    try {
      var body = json.encode(params);
      var response = await http.post(signInUrl,
          headers: {"Accept": "application/json"}, body: body);
      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        final String? token = body['token'];
        final String? error = body['error'];
        if (body.containsValue(token)) {
          return token!;
          
        } else {
          throw Exception(error);
        }
      } else {
        return throw Exception(
            'Ошибка авторизации, попробуйте еще раз, позже.');
      }
    } catch (e) {
      errorDialog.showError(e.toString());
      return null;
    }
  }
}
