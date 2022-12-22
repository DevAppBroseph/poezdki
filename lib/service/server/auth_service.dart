import 'dart:convert';
import 'package:app_poezdka/export/server_url.dart';
import 'package:app_poezdka/model/server_responce.dart';
import 'package:app_poezdka/model/user_model.dart';

import 'package:app_poezdka/widget/dialog/error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      required int birth,
      required String fcmToken,
      required String? referal}) async {
    Map<String, dynamic> params = {
      "login": login,
      "password": password,
      "firstname": firstName,
      "lastname": lastName,
      "gender": gender,
      "birth": "$birth",
      "fcm_token": fcmToken,
      if(referal != null) "ref": referal
    };

    try {
      var body = json.encode(params);
      var response = await http.post(signUpUrl,
          headers: {"Accept": "application/json"}, body: body);
      if (response.statusCode == 200) {
        final resp = ResponceAuth.fromJson(response.body);

        return resp;
      } else {
        if (response.body ==
            'Something goes wrong: UNIQUE constraint failed: users.login') {
          errorDialog.showError('Такой пользователь уже существует.');
        } else if (response.body == 'login must be email or phone number') {
          errorDialog.showError('Логин указан неправильно');
        } else {
          errorDialog.showError(response.body);
        }
      }
    } catch (e) {
      errorDialog.showError(e.toString());
      return null;
    }
    return null;
  }

  Future<UserModel?> signWithService(
      GoogleSignInAccount account, String fcmToken) async {
    // try {
    Response res;
    var dio = Dio();

    try {
      res = await dio.post(
        "$serverURL/users/oauth_user",
        options: Options(
          validateStatus: ((status) => status! >= 200),
        ),
        data: UserModel(
          email: account.email,
          firstname: account.displayName?.split(" ").first,
          lastname: account.displayName?.split(" ").last,
          fcmToken: fcmToken,
        ).toJson(),
      );
      return UserModel.fromJson(res.data);
    } catch (e) {
      errorDialog.showError(e.toString());
    }
    return null;
  }

  Future deleteUser({required String token}) async {
    var dio = Dio();

    await dio.delete(
      "$serverURL/users/delete_user",
      options: Options(
        validateStatus: ((status) => status! == 200),
        headers: {"Authorization": token},
      ),
    );
  }

  Future<UserModel?> signWithVk(UserModel account, String fcmToken) async {
    account.fcmToken = fcmToken;
    Response res;
    var dio = Dio();

    res = await dio.post(
      "$serverURL/users/oauth_user",
      options: Options(
        validateStatus: ((status) => status! >= 200),
      ),
      data: account.toJson(),
    );
    return UserModel.fromJson(res.data);
  }

  Future<ResponceAuth?> signIn({
    required String login,
    required String password,
    required String fcmToken,
  }) async {
    Map<String, dynamic> params = {
      "login": login,
      "password": password,
      "fcm_token": fcmToken,
    };

    try {
      var body = json.encode(params);
      var response = await http.post(signInUrl,
          headers: {"Accept": "application/json"}, body: body);
      if (response.statusCode == 200) {
        final resp = ResponceAuth.fromJson(response.body);
        if (resp.token.isNotEmpty) {
          return resp;
        } else {
          errorDialog.showError('Неправильно указал Телефон или пароль');
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
