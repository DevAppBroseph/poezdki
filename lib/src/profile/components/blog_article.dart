import 'package:flutter/material.dart';

class BlogArticle extends StatelessWidget {
  const BlogArticle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title =
        'Amet minim mollit non deserunt ullamco eat sit aliqua dolor do amet sint.';
    const src =
        'https://i.gaw.to/content/photos/29/70/297024_2017_Porsche_Cayenne.jpg';
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              constraints: BoxConstraints(maxHeight: 150, maxWidth: MediaQuery.of(context).size.width-20),
              decoration: const BoxDecoration(
                image: DecorationImage(image: NetworkImage(src), fit: BoxFit.cover),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Text(
            title + title + title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          )
        ],
      ),
    );
  }
}
