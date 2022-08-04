import 'package:app_poezdka/model/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';

import '../../../widget/divider/verical_dividers.dart';

class RideDetailsTrip extends StatelessWidget {
  final TripModel tripData;
  const RideDetailsTrip({Key? key, required this.tripData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final startTime =
        DateTime.fromMicrosecondsSinceEpoch(tripData.timeStart ?? 0 * 1000);
    final endTime = DateTime.fromMicrosecondsSinceEpoch(
        tripData.stops?.last.approachTime ?? 0 * 1000);
    return Row(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(left: 15),
              width: 30,
              // height: 130,
              child: _tripRoutIcon()),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                minLeadingWidth: 30,
                title: Text(
                  tripData.departure?.name ?? "",
                  maxLines: 1,
                ),
                subtitle: Text(
                  DateFormat("dd MMMM").format(startTime),
                  maxLines: 1,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15.0, top: 15, bottom: 15),
                child: Text(
                  " ",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: '.SF Pro Display',
                  ),
                ),
              ),
              ListTile(
                minVerticalPadding: 0,
                minLeadingWidth: 30,
                title: Text(
                  tripData.stops?.last.name ?? " ",
                  maxLines: 1,
                ),
                subtitle: Text(DateFormat("dd MMMM").format(endTime)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tripRoutIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Icon(
          FontAwesome5Regular.dot_circle,
          size: 20,
          color: Colors.grey,
        ),
        DivEnd(),
        DivEnd(),
        DivEnd(),
        DivEnd(),
        DivEnd(),
        DivEnd(),
        DivEnd(),
        DivEnd(),
        DivEnd(),
        DivEnd(),
        DivEnd(),
        DivEnd(),
        DivEnd(),
        DivEnd(),
        Icon(
          FontAwesome5Regular.dot_circle,
          size: 20,
          color: Colors.grey,
        ),
      ],
    );
  }
}
