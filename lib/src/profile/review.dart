import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';

import 'components/review_card.dart';



class Review extends StatelessWidget {
  const Review({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
        isLeading: true,
        title: "Отзывы",
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: kPrimaryWhite
          ),
          child: SingleChildScrollView(
            child: Column(
              children: const [
              ReviewCard(),
              ReviewCard(),
              ReviewCard(),
              ],
            ),
          ),
        ));
  }
}
