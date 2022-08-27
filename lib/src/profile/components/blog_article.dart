import 'package:flutter/material.dart';

class BlogArticle extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  const BlogArticle({
    Key? key,
    required this.image,
    required this.subtitle,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              constraints: BoxConstraints(
                  maxHeight: 150,
                  maxWidth: MediaQuery.of(context).size.width - 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          Text(
            subtitle,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          )
        ],
      ),
    );
  }
}
