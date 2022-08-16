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
    final endTime = DateTime.fromMicrosecondsSinceEpoch(
        tripData.stops?.last.approachTime ?? 0);
    return Row(
      children: [
        // Align(
        //   alignment: Alignment.topCenter,
        //   child: Container(
        //     alignment: Alignment.topCenter,
        //     margin: const EdgeInsets.only(left: 15),
        //     width: 30,
        //     // height: 130,
        //     child: _tripRoutIcon(),
        //   ),
        // ),
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
                    children: [
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
                      "dd MMMM",
                    ).format(startTime),
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              // const Padding(
              //   padding: EdgeInsets.only(left: 15.0, top: 15, bottom: 15),
              //   child: Text(
              //     " ",
              //     textAlign: TextAlign.start,
              //     style: TextStyle(
              //       color: Colors.grey,
              //       fontFamily: '.SF Pro Display',
              //     ),
              //   ),
              // ),
              // if (tripData.stops?.length == 1)
              //   SizedBox(
              //     height: 63,
              //     child: ListTile(
              //       minVerticalPadding: 0,
              //       minLeadingWidth: 30,
              //       leading: Column(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           DivEnd(),
              //           DivEnd(),
              //           DivEnd(),
              //           Icon(
              //             FontAwesome5Regular.dot_circle,
              //             size: 20,
              //             color: Colors.grey,
              //           ),
              //         ],
              //       ),
              //       title: Text(
              //         tripData.stops?.last.name ?? " ",
              //         maxLines: 1,
              //       ),
              //       subtitle: Text(DateFormat("dd MMMM").format(endTime)),
              //     ),
              //   )
              // else
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
                              DivEnd(),
                              DivEnd(),
                              if (index != tripData.stops!.length - 1) DivEnd(),
                              DivEnd(),
                              Icon(
                                FontAwesome5Regular.dot_circle,
                                size: 20,
                                color: Colors.grey,
                              ),
                              if (index != tripData.stops!.length - 1) DivEnd(),
                              if (index != tripData.stops!.length - 1) DivEnd(),
                              if (index != tripData.stops!.length - 1) DivEnd(),
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
                                DateFormat("dd MMMM").format(endTime),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      //  ListTile(
                      //   minVerticalPadding: 0,
                      //   minLeadingWidth: 30,
                      //   leading: Column(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       DivEnd(),
                      //       if (index != tripData.stops!.length - 1) DivEnd(),
                      //       DivEnd(),
                      //       Icon(
                      //         FontAwesome5Regular.dot_circle,
                      //         size: 20,
                      //         color: Colors.grey,
                      //       ),
                      //       if (index != tripData.stops!.length - 1) DivEnd(),
                      //       if (index != tripData.stops!.length - 1) DivEnd(),
                      //       // if (index != tripData.stops!.length - 1) DivEnd(),
                      //     ],
                      //   ),
                      //   title: Text(
                      //     tripData.stops?[index].name ?? " ",
                      //     maxLines: 1,
                      //   ),
                      //   subtitle: Text(DateFormat("dd MMMM").format(endTime)),
                      // ),
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
