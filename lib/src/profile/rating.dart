import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';

import 'components/rating_level.dart';

class Rating extends StatelessWidget {
  const Rating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
        backgroundColor: Colors.white,
        isLeading: true,
        title: "Рейтинг",
        body: SingleChildScrollView(
          child: Column(
            children: const [
              RatingLevel(
                img: 'turtule',
                level: "1 Уровень",
                goal: "Проехать 100 км.",
                award: "100 баллов",
              ),
              RatingLevel(
                img: 'tarantula',
                level: "2 Уровень",
                goal: "Проехать 500 км.",
                award: "200 баллов",
              ),
              RatingLevel(
                img: 'cat1',
                level: "3 Уровень",
                goal: "Проехать 1000 км.",
                award: "300 баллов",
              ),
              RatingLevel(
                img: 'dog1',
                level: "4 Уровень",
                goal: "Проехать 2000 км.",
                award: "400 баллов",
              ),
              RatingLevel(
                img: 'dog',
                isLastLevel: true,
                level: "5 Уровень",
                goal: "Проехать 3000 км.",
                award: "500 баллов",
              ),
            ],
          ),
        ));
  }
}
