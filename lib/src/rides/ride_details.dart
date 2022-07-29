import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/const/lorem_ipsum.dart';
import 'package:app_poezdka/database/database.dart';
import 'package:app_poezdka/src/chat/chat_screen.dart';
import 'package:app_poezdka/src/rides/components/book_place.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'components/ride_details_trip.dart';

class RideDetails extends StatelessWidget {
  final RideData rideData;
  const RideDetails({Key? key, required this.rideData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheetChildren(children: [
      _ownerInfo(context),
      _price(),
      _tripData(),
      _div(),
      _rideInfo(),
      _div(),
      _rideComment(),
      _rideButtons(context),
      
    ]);
  }

  Widget _rideButtons(context) {
    return Row(
      children: [
        Expanded(
            child: FullWidthElevButton(
          onPressed: () {},
          title: "Передать посылку",
          titleStyle: const TextStyle(fontSize: 13, color: Colors.white),
        )),
        Expanded(
            child: FullWidthElevButton(
          onPressed: () => pushNewScreen(context, screen: const BookingRidePlace()),
          title: "Забронировать",
          titleStyle: const TextStyle(fontSize: 13, color: Colors.white),
        ))
      ],
    );
  }

  Widget _rideComment() {
    return const ListTile(
      title: Text(loremIpsum),
    );
  }

  Widget _tripData() {
    return RideDetailsTrip(
      rideData: rideData,
    );
  }

  Widget _price() {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text(
          rideData.price.toString() + " ₽",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }

  Widget _rideInfo() {
    final mapInfo = {
      'Перевозка багажа': rideData.isBagadgeTransfer,
      '2 места на заднем сиденье': rideData.isTwoBackSeat,
      'Есть детское кресло': rideData.isChildSeat,
      'Можно с животными': rideData.isPetTransfer,
      'Кондиционер': rideData.isCondition,
      'Можно курить': rideData.isSmoking
    };
    return Column(
      children: [
        ListTile(
          title: const Text("Автомобиль"),
          trailing: Text(rideData.car?? " "),
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: mapInfo.length,
            itemBuilder: (context, int index) {
              String key = mapInfo.keys.elementAt(index);
              bool? value = mapInfo.values.elementAt(index);
              if (value == false) {
                return const Padding(padding: EdgeInsets.zero,);
              }
              return ListTile(
                title: Text(
                  key,
                  style: const TextStyle(
                    fontFamily: '.SF Pro Display',
                  ),
                ),
                trailing: const Icon(
                  Icons.check,
                  color: kPrimaryColor,
                ),
              );
            }),
      ],
    );
  }

  Widget _ownerInfo(context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: kPrimaryWhite, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const CircleAvatar(
          child: FlutterLogo(),
        ),
        title: Text(rideData.ownerName ?? ""),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.call,
                  color: kPrimaryColor,
                )),
            IconButton(
                onPressed: () => pushNewScreen(context, withNavBar: false, screen: const ChatScreen()),
                icon: const Icon(
                  Icons.chat_bubble,
                  color: kPrimaryColor,
                ))
          ],
        ),
      ),
    );
  }

  Widget _div() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Divider(),
    );
  }
}
