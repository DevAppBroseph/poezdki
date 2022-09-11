import 'package:app_poezdka/bloc/profile/profile_bloc.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:app_poezdka/service/server/user_service.dart';
import 'package:app_poezdka/model/rating.dart' as ratinguser;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/rating_level.dart';

class Rating extends StatefulWidget {
  const Rating({Key? key}) : super(key: key);
  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  ratinguser.Rating? userPerson;

  @override
  void initState() {
    super.initState();
    getRating();
  }

  List<String> images = ['tarantula', 'cat1', 'axolot', 'cat', 'turtule', 'dog1', 'dog'];

  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
        backgroundColor: Colors.white,
        isLeading: true,
        title: "Рейтинг",
        body: SingleChildScrollView(
          child: Column(
            children: [
              userPerson != null
              ? RatingLevel(
                  img: images[userPerson!.level%7],
                  level: "${userPerson!.level} Уровень",
                  goal: "Проехать ${100*userPerson!.level} км.",
                  award: "100 баллов",
              )
              : const SizedBox()
            ],
          ),
        ));
  }

  void getRating() {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.userRepository.getToken().then((token) {
      UserService().getRatingUser(token: token!).then((value) {
        userPerson = value;
        setState(() {});
      });
    });
  }
}
