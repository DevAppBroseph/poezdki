import 'dart:convert';
import 'package:app_poezdka/const/server/sever_chat.dart';
import 'package:app_poezdka/model/messages_answer.dart';
import 'package:app_poezdka/service/local/secure_storage.dart';

import 'package:app_poezdka/widget/dialog/error_dialog.dart';
import 'package:http/http.dart' as http;

class ChatService {
  final errorDialog = ErrorDialogs();
  static var chatsUrl = Uri.parse(getChatUrl);
  static var chatSupport = Uri.parse(checkChatSupport);

  Future<List<MessagesAnswer>?> getChat({
    required int senderId,
    required int receiverId,
    required String token,
  }) async {
    Map<String, dynamic> params = {
      "from_id": senderId,
      "to_id": receiverId,
    };

    try {
      var body = json.encode(params);
      var response = await http.post(
        chatsUrl,
        headers: {
          "Accept": "application/json",
          "Authorization": token,
        },
        body: body,
      );
      if (response.statusCode == 200) {
        final resp = messagesAnswerFromJson(response.body);

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

  Future<bool> checkReadMessage() async {
    final token = await SecureStorage.instance.getToken();
    var response = await http.get(
      chatSupport,
      headers: {
        "Accept": "application/json",
        "Authorization": token!,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['state'];
    }
    return false;
  }
}
