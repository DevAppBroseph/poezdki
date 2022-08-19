import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:scale_button/scale_button.dart';

class ReviewCard extends StatelessWidget {
  final String message;
  final num mark;
  final String date;
  const ReviewCard(
      {Key? key, required this.message, required this.mark, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const boldText = TextStyle(fontWeight: FontWeight.bold);
    return ScaleButton(
      bound: 0.05,
      duration: const Duration(milliseconds: 200),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 10,
                spreadRadius: 3,
                color: Color.fromRGBO(26, 42, 97, 0.06),
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
              child: Text(
                date.substring(0, 10),
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                message,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.star_outline, size: 18),
                    label: Text(
                      "$mark/5",
                      style: boldText,
                    )),
                TextButton.icon(
                  onPressed: null,
                  icon: const Icon(
                    Ionicons.share_outline,
                    size: 18,
                  ),
                  label: const Text(
                    "Пост",
                    style: boldText,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
