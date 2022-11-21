import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/widget/button/icon_box_button.dart';
import 'package:app_poezdka/widget/divider/row_divider.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class Referal extends StatelessWidget {
  const Referal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
        isLeading: true,
        title: "Реферальная система",
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const ListTile(
                  title: Text(
                    "Это ваша реферальная ссылка.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  subtitle: Text(
                      "\nЗа каждого нового пользователя кто установит приложение по вашей ссылке, Вы получите 100 баллов."),
                ),
                referalBox(context),
                const KDivider(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    text: "Поделиться"),
                shareButtons()
              ],
            ),
          ),
        ));
  }

  Widget referalBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
      child: InkWell(
        onTap: () async {
          await Clipboard.setData(
              const ClipboardData(text: "www.link//32ws2cw"));
          const _snackBar = SnackBar(
            backgroundColor: kPrimaryColor,
            content: Text('Скопировано'),
            duration: Duration(seconds: 1),
          );
          ScaffoldMessenger.of(context).showSnackBar(_snackBar);
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
          child: const ListTile(
            title: Text(
              "www.link//32ws2cw",
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(
              Ionicons.copy_outline,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget shareButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        IconBoxButton(
          child: Icon(
            MaterialCommunityIcons.vk,
            color: Colors.blue,
          ),
        ),
        IconBoxButton(
          child: Icon(
            MaterialCommunityIcons.whatsapp,
            color: Colors.green,
          ),
        ),
        IconBoxButton(
          child: Icon(
            MaterialCommunityIcons.twitter,
            color: Colors.blue,
          ),
        ),
        IconBoxButton(
          child: Icon(
            MaterialCommunityIcons.telegram,
            color: Colors.blueAccent,
          ),
        ),
        IconBoxButton(
          child: Icon(
            Fontisto.viber,
            color: Colors.purple,
          ),
        ),
      ],
    );
  }
}
