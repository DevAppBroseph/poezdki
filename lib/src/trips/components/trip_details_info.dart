import 'dart:math';
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
    double distance = 0;
    
    distance += calculateDistance(tripData.departure!.coords!.lat!, tripData.departure!.coords!.lon!, tripData.stops![0].coords!.lat!, tripData.stops![0].coords!.lon!);
    for(int i = 1; i < tripData.stops!.length - 1; i++) {
      distance += calculateDistance(tripData.stops![i].coords!.lat!, tripData.stops![i].coords!.lon!, tripData.stops![i+1].coords!.lat!, tripData.stops![i+1].coords!.lon!);
    }
    distance += (distance * 20)/100;

    final startTime =
        DateTime.fromMicrosecondsSinceEpoch(tripData.timeStart ?? 0);
    final endTime = DateTime.fromMicrosecondsSinceEpoch(
        tripData.stops?.last.approachTime?.toInt() ?? 0);
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 63,
                child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(
                        FontAwesome5Regular.dot_circle,
                        size: 20,
                        color: Colors.grey,
                      ),
                      DivEnd(),
                      DivEnd(),
                      DivEnd(),
                    ],
                  ),
                  minLeadingWidth: 30,
                  title: Text(
                    tripData.departure?.name ?? "",
                    maxLines: 1,
                    style: const TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    DateFormat(
                      "dd MMMM, HH:mm",
                      'RU',
                    ).format(startTime),
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 63,
                child: ListTile(
                minVerticalPadding: 0,
                minLeadingWidth: 30,
                leading: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      SizedBox(width: 20, height: 20),
                      DivEnd(),
                      DivEnd(),
                      DivEnd(),
                    ],
                  ),
                title: Text(
                  distance.toInt().toString() + ' км',
                  maxLines: 1,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                // subtitle: Text(distance.toStringAsFixed(2) + 'км')
              ),
              ),
              SizedBox(
                height: tripData.stops!.length.toDouble() * 70,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 16),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const DivEnd(),
                              const DivEnd(),
                              if (index != tripData.stops!.length - 1) const DivEnd(),
                              const DivEnd(),
                              const Icon(
                                FontAwesome5Regular.dot_circle,
                                size: 20,
                                color: Colors.grey,
                              ),
                              if (index != tripData.stops!.length - 1) const DivEnd(),
                              if (index != tripData.stops!.length - 1) const DivEnd(),
                              if (index != tripData.stops!.length - 1) const DivEnd(),
                            ],
                          ),
                          const SizedBox(width: 25),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tripData.stops?[index].name ?? " ",
                                maxLines: 1,
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                DateFormat("dd MMMM, HH:mm", 'RU').format(
                                  DateTime.fromMicrosecondsSinceEpoch(
                                    tripData.stops?[index].approachTime
                                            ?.toInt() ??
                                        0,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: tripData.stops?.length,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
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
