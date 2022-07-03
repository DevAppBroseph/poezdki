import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class InfoDialog {
  void show(
      {double? height,
      double? width,
      String? img,
      Widget? customIcon,
      required String title,
       String? description,
       List<Widget>? children
       }) {
    SmartDialog.show(
      builder: (context) => Align(
        alignment: Alignment.center,
        child: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                constraints: const BoxConstraints(minHeight: 351, maxHeight: 700),
                // height: height ?? 351,
                width: width ?? 600,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      img != null ? Image.asset(img) : const SizedBox(),
                      customIcon ?? const SizedBox(),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                     description != null ? Text(
                        description,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ) : Column(children: children ?? [],),
                      const SizedBox(
                        height: 10,
                      ),
                      FullWidthElevButton(
                        title: "Хоршо",
                        onPressed: () => SmartDialog.dismiss(),
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
