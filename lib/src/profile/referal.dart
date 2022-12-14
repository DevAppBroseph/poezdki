import 'package:app_poezdka/bloc/profile/profile_bloc.dart';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/export/server_url.dart';
import 'package:app_poezdka/model/user_model.dart';
import 'package:app_poezdka/widget/button/icon_box_button.dart';
import 'package:app_poezdka/widget/divider/row_divider.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class Referal extends StatefulWidget {
  Referal({Key? key}) : super(key: key);

  @override
  State<Referal> createState() => _ReferalState();
}

class _ReferalState extends State<Referal> {
  String referalStr = '$serverURL/users/registration?ref=';

  @override
  void initState() {
    _createReferalLink();
    super.initState();
  }

  void _createReferalLink() async {
    UserModel? userModel = BlocProvider.of<ProfileBloc>(context).userModel;
    referalStr = userModel != null ? referalStr + userModel.ref! : '';
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://apppoezdka.page.link/"),
      uriPrefix: "https://apppoezdka.page.link/n3UL",
      longDynamicLink:
          Uri.parse('https://apppoezdka.page.link/${userModel!.ref!}'),
      iosParameters: const IOSParameters(
        bundleId: 'dev.broseph.poezdka',
        minimumVersion: '13.0',
        appStoreId: '6443941402',
      ),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);

    setState(() {
      referalStr = dynamicLink.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel? userModel = BlocProvider.of<ProfileBloc>(context).userModel;
    // if (referalStr == '$serverURL/users/registration?ref=') {
    //   referalStr = userModel != null ? referalStr + userModel.ref! : '';
    // }

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
          await Clipboard.setData(ClipboardData(text: referalStr));
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
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    referalStr,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                Ionicons.copy_outline,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget shareButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconBoxButton(
          referalStr: referalStr,
          child: const Icon(
            MaterialCommunityIcons.vk,
            color: Colors.blue,
          ),
        ),
        IconBoxButton(
          referalStr: referalStr,
          child: const Icon(
            MaterialCommunityIcons.whatsapp,
            color: Colors.green,
          ),
        ),
        IconBoxButton(
          referalStr: referalStr,
          child: const Icon(
            MaterialCommunityIcons.twitter,
            color: Colors.blue,
          ),
        ),
        IconBoxButton(
          referalStr: referalStr,
          child: const Icon(
            MaterialCommunityIcons.telegram,
            color: Colors.blueAccent,
          ),
        ),
        IconBoxButton(
          referalStr: referalStr,
          child: const Icon(
            Fontisto.viber,
            color: Colors.purple,
          ),
        ),
      ],
    );
  }
}
