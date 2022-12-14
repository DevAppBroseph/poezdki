import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class ProgressDialog {
  void show({
    double? height,
    double? width,
    String? img,
    Widget? customIcon,
    required String title,
    String? description,
    List<Widget>? children,
    Function? onPressed,
  }) {
    SmartDialog.show(
      clickMaskDismiss: false,
      backDismiss: false,
      maskColor: const Color.fromRGBO(6, 22, 46, 0.67),
      builder: (context) => Align(
        alignment: Alignment.center,
        child: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                constraints:
                    BoxConstraints(minHeight: height ?? 351, maxHeight: 700),
                // height: height ?? 351,
                width: width ?? 600,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 10,
                        spreadRadius: 3,
                        color: Color.fromRGBO(26, 42, 97, 0.06),
                      ),
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(title),
                    ),
                    const CupertinoActivityIndicator(),
                    const SizedBox(height: 20)
                  ],
                ),
              )),
        ),
      ),
      alignment: Alignment.center,
    );
  }
}
