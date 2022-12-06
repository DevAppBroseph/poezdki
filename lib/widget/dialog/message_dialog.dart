import 'package:app_poezdka/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class MessageDialogs {
  void showMessage(String? from, String message) {
    SmartDialog.showToast('',
        displayTime: const Duration(seconds: 3),
        builder: (context) => Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 10,
                      spreadRadius: 3,
                      color: Color.fromRGBO(26, 42, 97, 0.06),
                    ),
                  ],
                ),
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    minLeadingWidth: 10,
                    leading: from == 'BAZA'
                        ? const Icon(
                            MaterialCommunityIcons.information,
                            color: kPrimaryColor,
                            size: 30,
                          )
                        : SvgPicture.asset(
                            'assets/icon/messages-2.svg',
                            width: 30,
                            height: 30,
                          ),
                    title: Text(from == 'BAZA' ? 'Внимание' : from!),
                    subtitle: Text(from == 'BAZA'
                        ? message != 'cancel booking'
                            ? "Вашу поездку забронировали"
                            : 'Забронированная поездка была отменена.'
                        : message),
                  ),
                ),
              ),
            ),
        alignment: Alignment.topLeft,
        maskColor: Colors.transparent);
  }

  void showAlert(String? from, String message) {
    SmartDialog.showToast('',
        displayTime: const Duration(seconds: 3),
        builder: (context) => Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 10,
                      spreadRadius: 3,
                      color: Color.fromRGBO(26, 42, 97, 0.06),
                    ),
                  ],
                ),
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    minLeadingWidth: 10,
                    leading: const Icon(
                      MaterialCommunityIcons.information,
                      color: kPrimaryColor,
                      size: 30,
                    ),
                    title: Text(from!),
                    subtitle: Text(message),
                  ),
                ),
              ),
            ),
        alignment: Alignment.topLeft,
        maskColor: Colors.transparent);
  }
  //TODO прикрутить логику вывода алертов с Валерой

  // String _getStatus(String message) {
  //   if (message == 'cancel booking') {
  //     return 'Ваша бронь была отменена';
  //   }

  // }
}
