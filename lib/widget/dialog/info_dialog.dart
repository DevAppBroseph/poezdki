import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';

class InfoDialog {
  void show(
      {double? height,
      double? width,
      String? img,
      Widget? customIcon,
      required String title,
      String? description,
      List<Widget>? children,
      Function? onPressed}) {
    SmartDialog.show(
      maskColor: Color.fromRGBO(6, 22, 46, 0.67),
      builder: (context) => Align(
        alignment: Alignment.center,
        child: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                constraints:
                    const BoxConstraints(minHeight: 351, maxHeight: 700),
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      img != null ? SvgPicture.asset(img) : const SizedBox(),
                      customIcon ?? const SizedBox(),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      description != null
                          ? Text(
                              description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            )
                          : Column(
                              children: children ?? [],
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      FullWidthElevButton(
                        title: "Хорошо",
                        onPressed: onPressed != null
                            ? onPressed as void Function()?
                            : () => SmartDialog.dismiss(),
                      )
                    ],
                  ),
                ),
              )),
        ),
      ),
      alignment: Alignment.center,
    );
  }
}
