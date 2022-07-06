import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/database/database.dart';
import 'package:app_poezdka/src/profile/cars_data/add_car.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PersonalData extends StatelessWidget {
  const PersonalData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<MyDatabase>(context).userDao;
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
      body: FutureBuilder<UserData?>(
          future: db.getUserData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text("Ooops! Возникла ошибка."),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              final user = snapshot.data!;
              return ListView(
                children: [
                  ProfileInfo(
                    name: "${user.name} ${user.surname}",
                    imageUrl: profileImg,
                  ),
                  Container(
                    color: kPrimaryWhite,
                    child: Column(
                      children: [
                        ProfileDataCard(
                          user: user,
                        ),
                        ProfileCarsData(
                          user: user,
                        ),
                        const SizedBox(
                          height: 60,
                        )
                      ],
                    ),
                  )
                ],
              );
            }
            return const CircularProgressIndicator();
          }),
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
  final UserData user;
  const ProfileDataCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        child: Column(
          children: [
            const ListTile(
              dense: true,
              title: Text(
                "Профиль",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            ListTile(
              title: const Text(
                "Дата рождения",
              ),
              trailing: Text(DateFormat("dd.MM.yyyy")
                  .format(DateTime.fromMillisecondsSinceEpoch(user.dob!))),
            ),
            ListTile(
              title: const Text("Пол"),
              trailing: Text("${user.gender}"),
            ),
            ListTile(
              title: const Text("E-mail"),
              trailing: Text("${user.login!.contains("@") ? user.login : ""}"),
            ),
            ListTile(
              title: const Text("Телефон"),
              trailing: Text(user.login!.contains("@") ? "" : user.login!),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileCarsData extends StatelessWidget {
  final UserData user;
  const ProfileCarsData({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final btmCall = BottomSheetCall();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              dense: true,
              title: Text(
                "Автомобиль",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            MyCarList(
              userId: user.id!,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TextButton(
                  onPressed: () => btmCall.show(context,
                   child: const AddCarWidget()),
                  child: const Text(
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

class MyCarList extends StatelessWidget {
  final int userId;
  const MyCarList({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carsDB = Provider.of<MyDatabase>(context).carDao;
    return FutureBuilder<List<CarData>>(
        future: carsDB.getUserCars(userId),
        builder: (context, snapshot) {
          final cars = snapshot.data ?? [];
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cars.length,
              itemBuilder: (context, int index) => ListTile(
                    title: Text(
                      "${cars[index].mark}",
                    ),
                    trailing: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Удалить",
                          style: TextStyle(color: Colors.red),
                        )),
                  ));
          // if (snapshot.connectionState == ConnectionState.done) {
          //   final cars = snapshot.data ?? [];
          //   return ListView.builder(
          //       physics: const NeverScrollableScrollPhysics(),
          //       shrinkWrap: true,
          //       itemCount: cars.length,
          //       itemBuilder: (context, int index) => ListTile(
          //             title: Text(
          //               "${cars[index].mark}",
          //             ),
          //             trailing: TextButton(
          //                 onPressed: () {},
          //                 child: const Text(
          //                   "Удалить",
          //                   style: TextStyle(color: Colors.red),
          //                 )),
          //           ));
          // }
          // return const CircularProgressIndicator();
        });
  }
}
