import 'package:app_poezdka/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';

import '../../../widget/divider/verical_dividers.dart';

class RideDetailsTrip extends StatelessWidget {
  final RideData rideData;
  const RideDetailsTrip({Key? key, required this.rideData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  rideData.from ?? "Казань",
                  maxLines: 1,
                ),
                subtitle: Text(
                  "${DateFormat("dd MMMM").format(rideData.date!)}, ${rideData.time!.hour.toString().padLeft(2, '0')}:${rideData.time!.minute.toString().padLeft(2, '0')} - Автовокзал",
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 15, bottom: 15),
                child: Text(
                  "200 km",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontFamily: '.SF Pro Display',),
                  
                ),
              ),
              ListTile(
                minVerticalPadding: 0,
                minLeadingWidth: 30,
                title: Text(
                  rideData.to ?? "Казань",
                  maxLines: 1,
                ),
                // subtitle: const Text(" "),
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
