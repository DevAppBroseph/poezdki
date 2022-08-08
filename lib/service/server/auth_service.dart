import 'dart:convert';
import 'package:app_poezdka/export/server_url.dart';
import 'package:app_poezdka/model/server_responce.dart';

import 'package:app_poezdka/widget/dialog/error_dialog.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final errorDialog = ErrorDialogs();
  static var signUpUrl = Uri.parse(regUrl);
  static var signInUrl = Uri.parse(authUrl);

  Future<ResponceAuth?> signUp(
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
        final resp = ResponceAuth.fromJson(response.body);

        return resp;
      } else {
        return throw Exception(
            'Ошибка авторизации, попробуйте еще раз, позже.');
      }
    } catch (e) {
      errorDialog.showError(e.toString());
      return null;
    }
  }

  Future<ResponceAuth?> signIn({
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
        final resp = ResponceAuth.fromJson(response.body);
        if (resp.token.isNotEmpty) {
          return resp;
        }
      } else {
        return throw Exception(
            'Ошибка авторизации, попробуйте еще раз, позже.');
      }
    } catch (e) {
      errorDialog.showError(e.toString());
      return null;
    }
    return null;
  }
}
