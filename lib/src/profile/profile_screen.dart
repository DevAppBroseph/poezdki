import 'package:app_poezdka/src/profile/balance.dart';
import 'package:app_poezdka/src/profile/blog.dart';
import 'package:app_poezdka/src/profile/components/profile_button.dart';
import 'package:app_poezdka/src/profile/faq.dart';
import 'package:app_poezdka/src/profile/personal_data.dart';
import 'package:app_poezdka/src/profile/rating.dart';
import 'package:app_poezdka/src/profile/referal.dart';
import 'package:app_poezdka/src/profile/review.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
        title: "Профиль",
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.grey,
              ))
        ],
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProfileBtn(
                  onPressed: () =>
                      pushNewScreen(context, screen: const PersonalData()),
                  title: "Личные данные",
                  icon: 'profilepersonal'),
              ProfileBtn(
                  onPressed: () =>
                      pushNewScreen(context, screen: const Review()),
                  title: "Отзывы",
                  icon: 'likethumbup'),
              ProfileBtn(
                  onPressed: () =>
                      pushNewScreen(context, screen: const Rating()),
                  title: "Рейтинг",
                  icon: 'star'),
              const ProfileBtn(title: "Бонсуы", icon: 'dollar-circlebonus'),
              ProfileBtn(
                  onPressed: () =>
                      pushNewScreen(context, screen: const Referal()),
                  title: "Реферальная система",
                  icon: 'profile-2userreferal'),
              ProfileBtn(
                  onPressed: () =>
                      pushNewScreen(context, screen: const Balance()),
                  title: "Баланс",
                  icon: 'profile-2userreferal'),
              ProfileBtn(
                  onPressed: () => pushNewScreen(context, screen: const FAQ()),
                  title: "Вопросы и ответы",
                  icon: 'message-questionfaq'),
              ProfileBtn(
                  onPressed: () => pushNewScreen(context, screen: const Blog()),
                  title: "Блог",
                  icon: 'bookblog'),
              const ProfileBtn(
                  title: "О проекте",
                  icon: 'mouseabout'),
              const ProfileBtn(
                  title: "Пользовательское соглашение",
                  icon: 'document-textp_agree'),
              const ProfileBtn(
                  title: "Политика конфиденциальности",
                  icon: 'document-favoritep_privacy'),
              const ProfileBtn(
                  title: "Публичная оферта",
                  icon: 'document-textpublic_of'),
              const SignOutButton(),
            ],
          ),
        ));
  }
}
