import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class PersonalData extends StatelessWidget {
  const PersonalData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const profileImg =
        "https://images.unsplash.com/photo-1519011985187-444d62641929?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80";
    return KScaffoldScreen(
      isLeading: true,
      title: "Личные данные",
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
                MaterialCommunityIcons.dots_horizontal_circle_outline))
      ],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ProfileInfo(
              name: "Gracie Abrams",
              imageUrl: profileImg,
            ),
            Container(
              color: kPrimaryWhite,
              child: Column(
                children: [
                  const ProfileDataCard(),
                  ProfileCarsData(),
                  const SizedBox(height: 60,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({required this.imageUrl, required this.name, Key? key})
      : super(key: key);
  final String imageUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 230,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                imageUrl,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              name,
              style: const TextStyle(
                  color: kPrimaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDataCard extends StatelessWidget {
  const ProfileDataCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        child: Column(
          children: const [
            ListTile(
              dense: true,
              title: Text(
                "Профиль",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            ListTile(
              title: Text(
                "Дата рождения",
              ),
              trailing: Text("14.14.1990"),
            ),
            ListTile(
              title: Text("Пол"),
              trailing: Text("Женский"),
            ),
            ListTile(
              title: Text("E-mail"),
              trailing: Text("testmail@gmail.com"),
            ),
            ListTile(
              title: Text("Телефон"),
              trailing: Text("+7(123)456-78-90"),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileCarsData extends StatelessWidget {
  const ProfileCarsData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              dense: true,
              title: const Text(
                "Автомобиль",
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            ListTile(
              title: const Text(
                "BMW 3 Синия",
              ),
              trailing: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Удалить",
                    style: const TextStyle(color: Colors.red),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Добавить автомобиль",
                    style: TextStyle(color: kPrimaryColor),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
