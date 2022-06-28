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
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
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
                  icon: Icons.person_outlined),
              ProfileBtn(
                  onPressed: () =>
                      pushNewScreen(context, screen: const Review()),
                  title: "Отзывы",
                  icon: Icons.thumb_up_outlined),
              ProfileBtn(
                  onPressed: () =>
                      pushNewScreen(context, screen: const Rating()),
                  title: "Рейтинг",
                  icon: Icons.star),
              const ProfileBtn(title: "Бонсуы", icon: Icons.currency_bitcoin),
              ProfileBtn(
                  onPressed: () =>
                      pushNewScreen(context, screen: const Referal()),
                  title: "Реферальная система",
                  icon: Icons.group_outlined),
              ProfileBtn(
                  onPressed: () =>
                      pushNewScreen(context, screen: const Balance()),
                  title: "Баланс",
                  icon: MaterialCommunityIcons.cash),
              ProfileBtn(
                  onPressed: () => pushNewScreen(context, screen: FAQ()),
                  title: "Вопросы и ответы",
                  icon: MaterialCommunityIcons.message_alert_outline),
              ProfileBtn(
                  onPressed: () => pushNewScreen(context, screen: const Blog()),
                  title: "Блог",
                  icon: Icons.menu_book_outlined),
              const ProfileBtn(
                  title: "О проекте",
                  icon: MaterialCommunityIcons.send_circle_outline),
              const ProfileBtn(
                  title: "Пользовательское соглашение",
                  icon: MaterialCommunityIcons.file_document_outline),
              const ProfileBtn(
                  title: "Политика конфиденциальности",
                  icon: MaterialCommunityIcons.file_document_outline),
              const ProfileBtn(
                  title: "Публичная оферта",
                  icon: MaterialCommunityIcons.file_document_outline),
              const SignOutButton(),
            ],
          ),
        ));
  }
}
