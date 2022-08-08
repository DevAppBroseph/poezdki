import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/model/user_model.dart';
import 'package:app_poezdka/src/profile/cars_data/add_car.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../bloc/profile/profile_bloc.dart';
import '../../export/blocs.dart';

class PersonalData extends StatelessWidget {
  final UserModel user;
  const PersonalData({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final btm = BottomSheetCall();
    const profileImg =
        "https://images.unsplash.com/photo-1519011985187-444d62641929?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80";
    return KScaffoldScreen(
        isLeading: true,
        title: "Личные данные",
        // actions: [
        //   IconButton(
        //       onPressed: () => btm.show(context, child: EditProfileSheet()),
        //       icon: const Icon(
        //           MaterialCommunityIcons.dots_horizontal_circle_outline))
        // ],
        body: ListView(
          children: [
            ProfileInfo(
              name: "${user.firstname} ${user.lastname}",
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
        ));
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
  final UserModel user;
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
                  .format(DateTime.fromMillisecondsSinceEpoch(user.birth!))),
            ),
            ListTile(
              title: const Text("Пол"),
              trailing:
                  Text(user.gender!.contains("male") ? "Мужской" : "Женский"),
            ),
            ListTile(
              title: const Text("E-mail"),
              trailing: Text(user.login!.contains("@") ? user.login! : ""),
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
  final UserModel user;
  const ProfileCarsData({Key? key, required this.user}) : super(key: key);

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
              title: Text(
                "Автомобиль",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            MyCarList(
              cars: user.cars ?? [],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TextButton(
                  onPressed: () =>
                      pushNewScreen(context, screen: const AddCarWidget()),
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
  final List<Cars> cars;
  const MyCarList({Key? key, required this.cars}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context, listen: false);

    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: cars.length,
        itemBuilder: (context, int index) => ListTile(
              title: Text(
                "${cars[index].mark!} ${cars[index].model ?? ""} ${cars[index].color ?? ""}",
              ),
              // subtitle: Text(cars[index].vehicleNumber ?? "" ),
              trailing: TextButton(
                  onPressed: () => profileBloc.add(DeleteCar(cars[index].pk!)),
                  child: const Text(
                    "Удалить",
                    style: TextStyle(color: Colors.red),
                  )),
            ));
  }
}
