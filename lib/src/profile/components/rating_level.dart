import 'package:app_poezdka/const/colors.dart';
import 'package:flutter/material.dart';

class RatingLevel extends StatelessWidget {
  final bool? isLastLevel;
  final String level;
  final String goal;
  final String award;
  final String img;
  const RatingLevel(
      {Key? key,
      required this.award,
      required this.level,
      required this.goal,
      this.isLastLevel = false,
      required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Text('Пока приложение бесплатное баллы не монетизируются', style: TextStyle(fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _levelIcon(),
              Expanded(child: _levelInfo(level, goal)),
              _awardInfo(award)
            ],
          ),
        ],
      ),
    );
  }

  _levelIcon() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: kPrimaryWhite,
          // backgroundImage: AssetImage("assets/img/$img.png"),
          child: Image.asset(
            "assets/img/$img.png",
            scale: 1,
            width: 45,
            height: 45,
          ),
        ),
        SizedBox(
          height: isLastLevel == true ? 21 : 5,
        ),
        _divider(5),
        const SizedBox(
          height: 2,
        ),
        _divider(10),
        const SizedBox(
          height: 2,
        ),
        _divider(5),
      ],
    );
  }

  _levelInfo(String level, String goal) {
    return Column(
      children: [
        ListTile(
          title: Text(
            level,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(goal),
        ),
        const SizedBox(
          height: 25,
        )
      ],
    );
  }

  _awardInfo(String award) {
    return Text(
      award,
      style: const TextStyle(color: kPrimaryColor),
    );
  }

  _divider(double height) {
    return isLastLevel == true
        ? const SizedBox()
        : Container(
            decoration: BoxDecoration(
                color: kPrimaryWhite, borderRadius: BorderRadius.circular(10)),
            width: 2,
            height: height,
          );
  }
}
