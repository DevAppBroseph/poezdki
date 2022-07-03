import 'package:app_poezdka/src/rides/components/waypoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../const/colors.dart';
import '../../../widget/divider/verical_dividers.dart';

class WayPointField extends StatelessWidget {
  final WaypointType type;
  final Widget textField;
  const WayPointField({Key? key, required this.type, required this.textField}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Image.asset('assets/img/way_from.png'),
            const DivEnd()
          ],
        );

      case WaypointType.end:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const DivStart(),
            Image.asset(
              'assets/img/location.png',
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
            Image.asset(
              'assets/img/location.png',
              scale: 1.2,
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
