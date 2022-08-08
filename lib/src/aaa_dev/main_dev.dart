import 'package:app_poezdka/export/services.dart';
import 'package:app_poezdka/src/aaa_dev/city_picker_dev.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class MainDev extends StatelessWidget {
  const MainDev({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dev"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            FullWidthElevButton(
              title: "RideCreated",
              onPressed: () => centeredDialog(),
            ),
            FullWidthElevButton(
              title: "Pick City Widget",
              onPressed: () =>
                  pushNewScreen(context, screen: const PickCityDev()),
            ),
            FullWidthElevButton(
              title: "Get Token",
              onPressed: () async {
                final user = SecureStorage.instance;
                final token = await user.getToken();
                if (kDebugMode) {
                  print(token);
                }
              },
            ),
            FullWidthElevButton(
              title: "Get Id",
              onPressed: () async {
                final user = SecureStorage.instance;
                final id = await user.getUserId();
                if (kDebugMode) {
                  print(id);
                }
              },
            )
          ],
        )),
      ),
    );
  }

  void centeredDialog() => SmartDialog.show(
        builder: (context) => Align(
          alignment: Alignment.center,
          child: Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 351,
                  width: 600,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset("assets/img/like.png"),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Ваша поезка создана!",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Ожидайте попутчиков.",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FullWidthElevButton(
                        title: "Хоршо",
                        onPressed: () => SmartDialog.dismiss(),
                      )
                    ],
                  ),
                )),
          ),
        ),
        alignment: Alignment.center,
      );
}
