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
      required String fcmToken}) async {
    Map<String, dynamic> params = {
      "login": login,
      "password": password,
      "firstname": firstName,
      "lastname": lastName,
      "gender": gender,
      "birth": "$birth",
      "fcm_token": "$fcmToken",
    };

    try {
      var body = json.encode(params);
      var response = await http.post(signUpUrl,
          headers: {"Accept": "application/json"}, body: body);
      if (response.statusCode == 200) {
        final resp = ResponceAuth.fromJson(response.body);

        return resp;
      } else {
        print(response.body);
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
  }

  Future<UserModel?> signWithService(
      GoogleSignInAccount account, String fcmToken) async {
    print('1231231231231231');
    // try {
    Response res;
    var dio = Dio();

    try {
      res = await dio.post(
        "http://194.87.145.140/users/oauth_user",
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
      print(res.data);
      return UserModel.fromJson(res.data);
    } catch (e) {
      errorDialog.showError(e.toString());
    }
  }

  Future deleteUser({required String token}) async {
    // try {
    Response res;
    var dio = Dio();

    // try {
    res = await dio.delete(
      "http://194.87.145.140/users/delete_user",
      options: Options(
        validateStatus: ((status) => status! == 200),
        headers: {"Authorization": token},
      ),
    );
    // } catch (e) {
    //   errorDialog.showError(e.toString());
    // }
  }

  Future<UserModel?> signWithVk(UserModel account, String fcmToken) async {
    account.fcmToken = fcmToken;
    print(account);
    // try {
    Response res;
    var dio = Dio();

    // try {
    res = await dio.post(
      "http://194.87.145.140/users/oauth_user",
      options: Options(
        validateStatus: ((status) => status! >= 200),
      ),
      data: account.toJson(),
    );
    print(res.data);
    return UserModel.fromJson(res.data);
    // } catch (e) {
    //   errorDialog.showError(e.toString());
    // }
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
          errorDialog.showError('Неправильно указал E-Mail или пароль');
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
