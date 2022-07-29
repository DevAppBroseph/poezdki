import 'package:app_poezdka/model/user_model.dart';

import '../../widget/dialog/error_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_poezdka/export/server_url.dart';

class UserService {
  final errorDialog = ErrorDialogs();
  static var getCurrentUserUrl = Uri.parse(currentUser);

  Future<UserModel?> getCurrentUser({required String token}) async {
    try {
      var response = await http.get(
        getCurrentUserUrl,
        headers: {"Authorization": token},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        final UserModel user = UserModel.fromJson(body);
        return user;
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
