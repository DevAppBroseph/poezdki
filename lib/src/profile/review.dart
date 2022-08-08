import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/const/server/server_review.dart';
import 'package:app_poezdka/model/review_model.dart';
import 'package:app_poezdka/service/local/secure_storage.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:dio/dio.dart';
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
            decoration: const BoxDecoration(color: kPrimaryWhite),
            child: FutureBuilder<ReviewModel?>(
              future: fetchReviews(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final reviews = snapshot.data?.reviews ?? [];
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: reviews.length,
                      itemBuilder: ((context, index) => ReviewCard(
                            message: reviews[index].message!,
                            mark: reviews[index].mark!,
                            date: reviews[index].date!,
                          )));
                }
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(),
                );
              }),
            )));
  }

  Future<ReviewModel?> fetchReviews() async {
    Response response;
    final dio = Dio();

    try {
      final token = await SecureStorage.instance.getToken();

      response = await dio.get(reviewUrl,
          options: Options(
              headers: {"Authorization": token},
              responseType: ResponseType.json));
      if (response.statusCode == 200) {
        return ReviewModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
