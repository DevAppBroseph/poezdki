import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/src/profile/components/blog_article.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';



class Blog extends StatelessWidget {
  const Blog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KScaffoldScreen(
        isLeading: true,
        title: "Блог",
        body: Container(
          color: kPrimaryWhite,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: 3,
            itemBuilder: (context, int indet) => const  BlogArticle()),
        ));
  }
}
