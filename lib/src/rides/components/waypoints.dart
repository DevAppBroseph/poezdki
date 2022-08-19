import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/widget/divider/verical_dividers.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';

enum WaypointType { start, empty, middle, end }

class WayPoints extends StatelessWidget {
  final TextEditingController startWay;
  final TextEditingController endWay;
  final List<TextEditingController>? midWays;
  final List<TextEditingController> midwayControllers;
  final Function pickDestinitionFrom;
  final Function pickDestinitionTo;
  final Function pickDestinitionStops;
  final Function onAdd;
  final Function(int index)? onTap;
  final Function onDelete;
  final int? midWayIndex;

  const WayPoints(
      {Key? key,
      required this.startWay,
      required this.endWay,
      this.onTap,
      required this.midWays,
      required this.onAdd,
      required this.onDelete,
      this.midWayIndex,
      required this.midwayControllers,
      required this.pickDestinitionFrom,
      required this.pickDestinitionTo,
      required this.pickDestinitionStops})
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
            readOnly: true,
            onTap: pickDestinitionFrom,
            hintText: "Откуда",
            textEditingController: startWay,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                'assets/img/gps.svg',
                width: 20,
                height: 20,
              ),
            ),
          ),
        ),
        midWays != null
            ? ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: midWays!.length,
                itemBuilder: (context, int index) => _wayPoint(
                      onDelete: () {},
                      type: WaypointType.middle,
                      textField: KFormField(
                        onTap: () {
                          // midwayControllers.add(TextEditingController());
                          onTap!(index);
                        },
                        readOnly: true,
                        hintText: "Куда",
                        textEditingController: midwayControllers[index],
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            'assets/img/gps.svg',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ))
            : const SizedBox(),
        midWays != null
            ? midWays!.length < 3
                ? _wayPoint(
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
                              color: kPrimaryDarkGrey,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 10,
                  )
            : _wayPoint(
                type: WaypointType.empty,
                textField: const Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(),
                ),
              ),
        _wayPoint(
          type: WaypointType.end,
          textField: KFormField(
            readOnly: true,
            onTap: pickDestinitionTo,
            hintText: "Куда",
            textEditingController: endWay,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                'assets/img/gps.svg',
                width: 20,
                height: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _wayPoint(
      {required WaypointType type,
      required Widget textField,
      Function? onDelete}) {
    return Container(
        margin:
            type == WaypointType.middle ? const EdgeInsets.only(top: 10) : null,
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
                SizedBox(
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
            )),
            // type == WaypointType.middle
            //     ? IconButton(
            //         onPressed: onDelete as void Function()?,
            //         icon: Icon(
            //           Icons.cancel,
            //           color: Colors.red,
            //         ))
            //     : const SizedBox()
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
            SvgPicture.asset(
              'assets/img/way_from.svg',
              width: 30,
              height: 30,
            ),
            const DivEnd()
          ],
        );

      case WaypointType.end:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const DivStart(),
            SvgPicture.asset(
              'assets/img/location.svg',
              width: 35,
              height: 35,
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        );

      case WaypointType.empty:
        return const DivMiddle();

      case WaypointType.middle:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const DivStart(),
            SvgPicture.asset(
              'assets/img/location.svg',
              width: 35,
              height: 35,
            ),
            const DivEnd(),
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
