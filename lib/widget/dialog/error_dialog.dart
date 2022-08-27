import 'package:app_poezdka/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ErrorDialogs {
  void showError(String? msg) {
    SmartDialog.showToast('',
        displayTime: const Duration(seconds: 3),
        builder: (context) => Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 10,
                    spreadRadius: 3,
                    color: Color.fromRGBO(26, 42, 97, 0.06),
                  ),
                ]),
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    minLeadingWidth: 10,
                    leading: const Icon(
                      MaterialCommunityIcons.information,
                      color: kPrimaryColor,
                      size: 30,
                    ),
                    title: Text(msg ?? "Возникла ошибка. Пропробуйте еще раз."),
                  ),
                ),
              ),
            ),
        alignment: Alignment.topLeft,
        maskColor: Colors.transparent);
  }
}
