import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/divider/verical_dividers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';

import '../../trips/components/trip_details_sheet.dart';

class RideTile extends StatelessWidget {
  final TripModel tripData;
  final bool? isUpcoming;
  final String? distance;
  final Function? onTap;
  const RideTile(
      {Key? key,
      required this.tripData,
      this.isUpcoming = false,
      this.distance,
      this.onTap})
      : super(key: key);

  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(BuildContext ctx) {
    return InkWell(
      onTap: (() => BottomSheetCall().show(ctx,
          useRootNavigator: true, child: TripDetailsSheet(trip: tripData))),
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                leading: const CircleAvatar(
                  child: FlutterLogo(),
                  backgroundColor: kPrimaryWhite,
                ),
                title: Text(tripData.owner.toString()),
                subtitle: Text(
                    "${tripData.car} - ${tripData.price!.toStringAsFixed(0)} рублей"),
              ),
              _trip(tripData),
              isUpcoming!
                  ? FullWidthElevButton(
                      title: "Отменить поездку",
                      onPressed: () {},
                    )
                  : const SizedBox()
            ],
          )),
    );
  }

  Widget _trip(TripModel? tripData) {
    final startTime =
        DateTime.fromMicrosecondsSinceEpoch(tripData?.timeStart ?? 0 * 1000);
  
    return Row(
      children: [
        Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(left: 15),
            width: 30,
            height: 105,
            child: _tripRoutIcon()),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                minLeadingWidth: 30,
                title: Text(
                  tripData!.departure?.name ?? "Казань",
                  maxLines: 1,
                ),
                subtitle: Text(
                  "${DateFormat("dd MMMM").format(startTime)},  - Автовокзал",
                  maxLines: 1,
                ),
              ),
              distance != null
                  ? ListTile(
                      subtitle: Text(distance!),
                    )
                  : const SizedBox(),
              ListTile(
                minVerticalPadding: 0,
                minLeadingWidth: 30,
                title: Text(
                  tripData.stops?.last.name ?? "Казань",
                  maxLines: 1,
                ),
                subtitle: const Text(" "),
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
        Icon(
          FontAwesome5Regular.dot_circle,
          size: 20,
          color: Colors.grey,
        ),
      ],
    );
  }
}
