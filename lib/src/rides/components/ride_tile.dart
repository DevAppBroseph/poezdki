import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/divider/verical_dividers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class RideTile extends StatelessWidget {
  const RideTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListTile(
            leading: CircleAvatar(
              child: FlutterLogo(),
              backgroundColor: kPrimaryWhite,
            ),
            title: Text("Айдар"),
            subtitle: Text("Белый Kia Rio - 1000 P."),
          ),
          _trip(),
          FullWidthElevButton(
            title: "Отменить поездку",
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget _trip() {
    return Column(
      children: [
        ListTile(
          minLeadingWidth: 30,
          leading: Container(
            width: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  FontAwesome5Regular.dot_circle,
                  size: 20,
                  color: Colors.grey,
                ),
                DivEnd(),
                DivEnd(),
              ],
            ),
          ),
          title: Text("Казань"),
          subtitle: Text("27 мая, 15:00 - Автовокзал"),
        ),
        
        ListTile(
          minVerticalPadding: 0,
          minLeadingWidth: 30,
          leading: SizedBox(
            width: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                DivEnd(),
                Icon(
                  FontAwesome5Regular.dot_circle,
                  size: 20,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          title: Text("Казань"),
          subtitle: Text("27 мая, 15:00 - Автовокзал"),
        ),
      ],
    );
  }
}
