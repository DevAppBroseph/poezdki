import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class ErrorDialogs {
  void showError(String? msg) {
    SmartDialog.showToast(msg ?? "Возникла ошибка");
  }
}
