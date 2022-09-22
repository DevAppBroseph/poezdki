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
    final startTime =
        DateTime.fromMicrosecondsSinceEpoch(tripData.timeStart ?? 0);
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 150,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 53,
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
                    height: tripData.stops!.length.toDouble() * 70,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        String? distanceRoute = distance(index);
                        return SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 16),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  DivEnd(),
                                  DivEnd(),
                                  DivEnd(),
                                  Icon(
                                    FontAwesome5Regular.dot_circle,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 25),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const DivEnd(),
                                  distanceRoute!=null 
                                  ? SizedBox(height: 20, child: Text('$distanceRoute км', style: const TextStyle(color: Colors.grey)))
                                  : const SizedBox(),
                                  const DivEnd(),
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
          ),
        ),
      ],
    );
  }

  String? distance(int index) {
    double distance = 0;
    if(index == 0) {
      distance += calculateDistance(tripData.departure!.coords!.lat!, tripData.departure!.coords!.lon!, tripData.stops![0].coords!.lat!, tripData.stops![0].coords!.lon!);
    } else {
      distance += calculateDistance(tripData.stops![index-1].coords!.lat!, tripData.stops![index-1].coords!.lon!, tripData.stops![index].coords!.lat!, tripData.stops![index].coords!.lon!);
    }
    distance += (distance * 20)/100;
    return '${distance.toInt()}';
  }

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }
}
