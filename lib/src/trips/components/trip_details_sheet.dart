import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/const/images.dart';
import 'package:app_poezdka/const/lorem_ipsum.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/src/chat/chat_screen.dart';
import 'package:app_poezdka/src/trips/components/book_trip.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'trip_details_info.dart';

class TripDetailsSheet extends StatelessWidget {
  final TripModel trip;
  const TripDetailsSheet({Key? key, required this.trip}) : super(key: key);

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
      _tripButtons(context),
    ]);
  }

  Widget _tripButtons(context) {
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
          onPressed: () =>
              pushNewScreen(context, screen:  BookTrip(tripData: trip,)),
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
      tripData: trip,
    );
  }

  Widget _price() {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: RichText(
          text: TextSpan(
              text: trip.price.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              children: const <TextSpan>[
                TextSpan(
                  text: ' ₽',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                )
              ]),
        ),
      ),
    );
  }

  Widget _rideInfo() {
    final mapInfo = {
      'Перевозка багажа': trip.package,
      '2 места на заднем сиденье': trip.twoPlacesInBehind,
      'Есть детское кресло': trip.babyChair,
      'Можно с животными': trip.animals,
      'Кондиционер': trip.conditioner,
      'Можно курить': trip.smoke
    };

    return Column(
      children: [
        ListTile(
          title: const Text("Автомобиль"),
          trailing: Text(
            "${trip.car?.mark ?? ""} ${trip.car?.model ?? ""} ${trip.car?.color ?? ""} ",
            maxLines: 1,
            overflow: TextOverflow.clip,
          ),
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: mapInfo.length,
            itemBuilder: (context, int index) {
              String key = mapInfo.keys.elementAt(index);
              bool? value = mapInfo.values.elementAt(index);
              if (value == false || value == null) {
                return const Padding(
                  padding: EdgeInsets.zero,
                );
              } else {
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
              }
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
        title: Text(trip.owner?.firstname ?? "Пользователь не найден"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset("$svgPath/call-calling.svg")),
            IconButton(
                onPressed: () => pushNewScreen(context,
                    withNavBar: false, screen: const ChatScreen()),
                icon: SvgPicture.asset("$svgPath/messages-2.svg"))
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
