
import 'package:app_poezdka/const/colors.dart';
import 'package:flutter/material.dart';

class DivMiddle extends StatelessWidget {
  const DivMiddle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          height: 2,
        ),
        Container(
          decoration: BoxDecoration(
              color: kPrimaryWhite, borderRadius: BorderRadius.circular(10)),
          width: 2,
          height: 5,
        ),
        const SizedBox(
          height: 2,
        ),
        Container(
          decoration: BoxDecoration(
              color: kPrimaryWhite, borderRadius: BorderRadius.circular(10)),
          width: 2,
          height: 7,
        ),
        const SizedBox(
          height: 2,
        ),
        Container(
          decoration: BoxDecoration(
              color: kPrimaryWhite, borderRadius: BorderRadius.circular(10)),
          width: 2,
          height: 7,
        ),
        const SizedBox(
          height: 2,
        ),
        Container(
          decoration: BoxDecoration(
              color: kPrimaryWhite, borderRadius: BorderRadius.circular(10)),
          width: 2,
          height: 7,
        ),
        const SizedBox(
          height: 2,
        ),
        Container(
          decoration: BoxDecoration(
              color: kPrimaryWhite, borderRadius: BorderRadius.circular(10)),
          width: 2,
          height: 5,
        ),
      ],
    );
  }
}

class DivStart extends StatelessWidget {
  const DivStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          height: 2,
        ),
        Container(
          decoration: BoxDecoration(
              color: kPrimaryWhite, borderRadius: BorderRadius.circular(10)),
          width: 2,
          height: 5,
        ),
      ],
    );
  }
}


class DivEnd extends StatelessWidget {
  const DivEnd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          height: 2,
        ),
        Container(
          decoration: BoxDecoration(
              color: kPrimaryWhite, borderRadius: BorderRadius.circular(10)),
          width: 2,
          height: 5,
        ),
      ],
    );
  }
}