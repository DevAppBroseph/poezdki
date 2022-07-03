import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/database/database.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/divider/verical_dividers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';

class RideTile extends StatelessWidget {
  final RideData rideData;
  final bool? isUpcoming;
  const RideTile({Key? key, required this.rideData, this.isUpcoming = false})
      : super(key: key);

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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(
              child:  FlutterLogo(),
              backgroundColor: kPrimaryWhite,
            ),
            title: Text(rideData.ownerName ?? ""),
            subtitle: Text(
                "${rideData.car} - ${rideData.price!.toStringAsFixed(0)} рублей"),
          ),
          _trip(rideData),
          isUpcoming!
              ? FullWidthElevButton(
                  title: "Отменить поездку",
                  onPressed: () {},
                )
              : const SizedBox()
        ],
      )
    );
  }

  Widget _trip(RideData? rideData) {
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
                  rideData!.from ?? "Казань",
                  maxLines: 1,
                ),
                subtitle: Text(
                  "${DateFormat("dd MMMM").format(rideData.date!)}, ${rideData.time!.hour.toString().padLeft(2, '0')}:${rideData.time!.minute.toString().padLeft(2, '0')} - Автовокзал",
                  maxLines: 1,
                ),
              ),
              ListTile(
                minVerticalPadding: 0,
                minLeadingWidth: 30,
                title: Text(
                  rideData.to ?? "Казань",
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
