import 'package:app_poezdka/bloc/profile/profile_builder.dart';
import 'package:app_poezdka/src/policy/policy.dart';
import 'package:app_poezdka/src/profile/about_project.dart';
import 'package:app_poezdka/src/profile/components/profile_button.dart';
import 'package:app_poezdka/src/profile/faq.dart';
import 'package:app_poezdka/src/profile/offert.dart';
import 'package:app_poezdka/src/profile/rating.dart';
import 'package:app_poezdka/src/profile/review.dart';
import 'package:app_poezdka/src/profile/users_confirm.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
        backgroundColor: Colors.white,
        title: "Профиль",
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProfileBtn(
                  onPressed: () => pushNewScreen(context,
                      screen: const PersonalDataBuilder()),
                  title: "Личные данные",
                  icon: 'profile'),
              ProfileBtn(
                  onPressed: () =>
                      pushNewScreen(context, screen: const Review()),
                  title: "Отзывы",
                  icon: 'like_small'),
              ProfileBtn(
                  onPressed: () =>
                      pushNewScreen(context, screen: const Rating()),
                  title: "Рейтинг",
                  icon: 'rate_star'),
              // const ProfileBtn(title: "Бонусы", icon: 'dollar-circlebonus'),
              // ProfileBtn(
              //     onPressed: () =>
              //         pushNewScreen(context, screen: const Referal()),
              //     title: "Реферальная система",
              //     icon: 'profile-2userreferal'),
              // ProfileBtn(
              //     onPressed: () =>
              //         pushNewScreen(context, screen: const Balance()),
              //     title: "Баланс",
              //     icon: 'profile-2userreferal'),
              ProfileBtn(
                onPressed: () => pushNewScreen(context, screen: const FAQ()),
                title: "Вопросы и ответы",
                icon: 'message-question',
              ),
              // ProfileBtn(
              //     onPressed: () => pushNewScreen(context, screen: const Blog()),
              //     title: "Блог",
              //     icon: 'book'),
              ProfileBtn(
                onPressed: () => pushNewScreen(context, screen: const AboutProject()),
                title: "О проекте", 
                icon: 'mouse'),
              ProfileBtn(
                onPressed: () => pushNewScreen(context, screen: const UsersConfirm()),
                title: "Пользовательское соглашение",
                icon: 'document-text',
              ),
              ProfileBtn(
                onPressed: () {
                  pushNewScreen(context, screen: const WebViewPage());
                },
                title: "Политика конфиденциальности",
                icon: 'document-favorite',
              ),
              ProfileBtn(
                onPressed: () => pushNewScreen(context, screen: const Offert()),
                title: "Публичная оферта", 
                icon: 'public_ofert'),
              const SignOutButton(),
            ],
          ),
        ));
  }
}
