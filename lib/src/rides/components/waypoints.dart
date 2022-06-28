import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/widget/divider/verical_dividers.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';

enum WaypointType { start, empty, middle, end }

class WayPoints extends StatelessWidget {
  final TextEditingController startWay;
  final TextEditingController endWay;
  final List<TextEditingController> midWays;
  final List<TextEditingController> midwayControllers;
  final Function onAdd;

   WayPoints(
      {Key? key,
      required this.startWay,
      required this.endWay,
      required this.midWays,
      required this.onAdd, required this.midwayControllers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        _wayPoint(
          type: WaypointType.start,
          textField: KFormField(
            hintText: "Откуда",
            textEditingController: startWay,
            suffixIcon: const Icon(
              Ionicons.locate,
              color: kPrimaryColor,
            ),
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: midWays.length,
            itemBuilder: (context, int index) => _wayPoint(
                  type: WaypointType.middle,
                  textField: KFormField(
                    hintText: "Куда",
                    textEditingController: midwayControllers[index],
                    suffixIcon: const Icon(
                      Ionicons.locate,
                      color: kPrimaryColor,
                    ),
                  ),
                )),
        _wayPoint(
          type: WaypointType.empty,
          textField: Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
                onPressed: onAdd as void Function(),
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: kPrimaryWhite,
                ),
                label: const Text(
                  "Промежуточное место",
                  style: TextStyle(
                      color: kPrimaryDarkGrey, fontWeight: FontWeight.w300),
                )),
          ),
        ),
        _wayPoint(
          type: WaypointType.end,
          textField: KFormField(
            hintText: "Куда",
            textEditingController: endWay,
            suffixIcon: const Icon(
              Ionicons.locate,
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _wayPoint({required WaypointType type, required Widget textField}) {
    return Container(
        margin: type == WaypointType.middle ? EdgeInsets.only(top: 10) : null,
        height: 60,
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // color: Colors.grey,
                  width: 60,
                  height: 55,
                  child: Center(
                    child: _leadingWaypointIcon(waypointType: type),
                  ),
                ),
              ],
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: textField,
            ))
          ],
        ));
  }

  _leadingWaypointIcon({required WaypointType waypointType}) {
    switch (waypointType) {
      case WaypointType.start:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Icon(
              FontAwesome5Regular.dot_circle,
              size: 35,
              color: kPrimaryColor,
            ),
            DivEnd()
          ],
        );

      case WaypointType.end:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DivStart(),
            const Icon(
              Ionicons.md_location_sharp,
              size: 40,
              color: kPrimaryColor,
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        );

      case WaypointType.empty:
        return DivMiddle();

      case WaypointType.middle:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DivStart(),
            const Icon(
              Ionicons.md_location_sharp,
              size: 30,
              color: kPrimaryColor,
            ),
            DivEnd(),
          ],
        );

      default:
        return const Icon(
          Ionicons.md_location_sharp,
          size: 40,
          color: kPrimaryColor,
        );
    }
  }

  
}
