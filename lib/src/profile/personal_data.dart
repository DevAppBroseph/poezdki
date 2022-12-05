import 'dart:convert';
import 'dart:io';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/const/server/server_data.dart';
import 'package:app_poezdka/model/user_model.dart';
import 'package:app_poezdka/src/profile/cars_data/add_car.dart';
import 'package:app_poezdka/src/profile/edit_profile.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:scale_button/scale_button.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../export/blocs.dart';

class PersonalData extends StatelessWidget {
  final UserModel user;
  const PersonalData({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
      backgroundColor: Colors.white,
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
            imageUrl: user.photo,
          ),
          Container(
            color: kPrimaryWhite,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: ProfileDataCard(
                    user: user,
                  ),
                ),
                ProfileCarsData(
                  user: user,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(DeleteProfile());
                  },
                  child: const Text('Удалить аккаунт'),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({required this.imageUrl, required this.name, Key? key})
      : super(key: key);
  final String? imageUrl;
  final String name;

  @override
  Widget build(BuildContext context) {

    // print('asdasdasd $imageUrl');
    return Center(
      child: SizedBox(
        height: 230,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleButton(
              bound: 0.05,
              duration: const Duration(milliseconds: 200),
              onTap: () async {
                final ImagePicker _picker = ImagePicker();
                // Pick an image
                await _picker
                    .pickImage(source: ImageSource.gallery)
                    .then((value) async {
                  if (value is XFile) {
                    var compressedFile = await compressFile(File(value.path));
                    var mime = lookupMimeType(value.path);
                    var bytes = compressedFile!.readAsBytesSync();
                    var media =
                        "data:${mime == 'video/quicktime' ? 'video/mp4' : mime};base64," +
                            base64Encode(bytes);
                    BlocProvider.of<ProfileBloc>(context)
                        .add(ChangePhoto(media));
                  }
                }).catchError((error) {
                  print(error);
                });
              },
              child: CircleAvatar(
                radius: 60,
                child: 
                imageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          width: 120,
                          height: 120,
                          child: CachedNetworkImage(
                            imageUrl: '$serverURL/$imageUrl',
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : const Icon(Icons.image, color: Colors.white, size: 50),
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
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<File?> compressFile(File file) async {
    final filePath = file.absolute.path;

    // Create output file path
    // eg:- "Volume/VM/abcd_out.jpeg"
    // var lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    // if(lastIndex == -1) lastIndex = filePath.lastIndexOf(RegExp(r'.png'));
    // final splitted = filePath.substring(0, (lastIndex));
    // final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var result = File(file.absolute.path);
    return result;
  }
}

class ProfileDataCard extends StatelessWidget {
  final UserModel user;
  const ProfileDataCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditProfile(
              user: user,
            ),
          ),
        );
      },
      bound: 0.05,
      duration: const Duration(milliseconds: 100),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 10,
              spreadRadius: 3,
              color: Color.fromRGBO(26, 42, 97, 0.06),
            ),
          ],
        ),
        child: Card(
          elevation: 0,
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
                trailing: user.birth != null
                    ? Text(DateFormat("dd.MM.yyyy").format(
                        DateTime.fromMillisecondsSinceEpoch(user.birth!)))
                    : const Text('Не указана'),
              ),
              ListTile(
                title: const Text("Пол"),
                trailing: Text(user.gender != null
                    ? user.gender == "male"
                        ? "Мужской"
                        : "Женский"
                    : 'Не указан'),
              ),
              // ListTile(
              //   title: const Text("E-mail"),
              //   trailing: Text(user.email ?? ''),
              // ),
              ListTile(
                title: const Text("Телефон"),
                trailing: Text(user.phone == null ? "Не указан" : user.phone!),
              )
            ],
          ),
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 10,
            spreadRadius: 3,
            color: Color.fromRGBO(26, 42, 97, 0.06),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
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
                ),
              ),
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
