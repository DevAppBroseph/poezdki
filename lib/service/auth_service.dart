import 'dart:convert';

import 'package:app_poezdka/widget/dialog/error_dialog.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static var regUrl = Uri.parse("http://ystories.site:8000/users/registration");
  static var authUrl = Uri.parse("http://ystories.site:8000/users/auth");

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
      var response = await http.post(regUrl,
          headers: {"Accept": "application/json"}, body: body);
      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        final String token = body['token'];
        return token;
      } else {
        return null;
      }
    } catch (e) {
      ErrorDialogs().showError(e.toString());
      return null;
    }
  }
}
