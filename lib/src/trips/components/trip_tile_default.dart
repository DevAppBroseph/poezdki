import 'dart:math';
import 'package:app_poezdka/const/images.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/src/trips/components/trip_details_sheet.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/cached_image/user_image.dart';
import 'package:app_poezdka/widget/divider/verical_dividers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:scale_button/scale_button.dart';

class TripTileDefault extends StatelessWidget {
  final TripModel trip;
  const TripTileDefault({Key? key, required this.trip}) : super(key: key);

  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(BuildContext context) {
    final ownerImage = trip.owner?.photo;
    final btmSheet = BottomSheetCall();
    return ScaleButton(
      bound: 0.05,
      duration: const Duration(milliseconds: 200),
      onTap: () {
        btmSheet.show(
          context,
          useRootNavigator: true,
          topRadius: const Radius.circular(50),
          child: TripDetailsSheet(
            trip: trip,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          // color: Color.fromARGB(255, 249, 243, 226),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 10,
              spreadRadius: 3,
              color: Color.fromRGBO(26, 42, 97, 0.06),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            // trip.isPremium != null && trip.isPremium!
            //     ? Padding(
            //         padding: const EdgeInsets.all(15.0),
            //         child: SvgPicture.asset(
            //           'assets/icon/premium.svg',
            //           height: 40,
            //         ),
            //       )
            //     : const SizedBox(),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  leading: UserCachedImage(
                    img: ownerImage,
                  ),
                  title: Text(
                    '${trip.owner!.firstname!} ${trip.owner!.lastname!}',
                    // "${((trip.owner!.firstname! + ' ' + trip.owner!.lastname!)) ?? " Пользователь не найден"}",
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(trip.passenger! ? 'Я Подвезу Вас' : 'Ищу поездку'),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 5, right: 5),
                      //   child: Container(
                      //     height: 5,
                      //     width: 5,
                      //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                      //     color: const Color.fromRGBO(191,212,228, 1))),
                      // ),
                      Text(
                        "${trip.price} ₽",
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                  trailing: SvgPicture.asset("$svgPath/archive-add.svg"),
                ),
                _trip(trip),
                // isUpcoming!
                //     ? FullWidthElevButton(
                //         title: "Отменить поездку",
                //         onPressed: () {},
                //       )
                //     : const SizedBox()
              ],
            ),
          ],
        ),
      ),
    );
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Widget _trip(TripModel? tripData) {
    double distance = 0;

    distance += calculateDistance(
        tripData!.departure!.coords!.lat!,
        tripData.departure!.coords!.lon!,
        tripData.stops![0].coords!.lat!,
        tripData.stops![0].coords!.lon!);
    for (int i = 1; i < tripData.stops!.length - 1; i++) {
      distance += calculateDistance(
          tripData.stops![i].coords!.lat!,
          tripData.stops![i].coords!.lon!,
          tripData.stops![i + 1].coords!.lat!,
          tripData.stops![i + 1].coords!.lon!);
    }
    distance += (distance * 20) / 100;

    final startTime = DateTime.fromMicrosecondsSinceEpoch(tripData.timeStart!);
    final endTime = DateTime.fromMicrosecondsSinceEpoch(
        tripData.stops?.last.approachTime?.toInt() ?? 0);
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
                  tripData.departure?.name ?? " ",
                  maxLines: 1,
                ),
                subtitle: Text(
                  DateFormat("dd MMMM, HH:mm", 'RU')
                      .format(startTime)
                      .toString(),
                  maxLines: 1,
                ),
              ),
              // trip.stops?.last.distanceToPrevious != null
              //     ? ListTile(
              //         subtitle: Text(trip.stops!.last.distanceToPrevious.toString()),
              //       )
              //     : const SizedBox(),
              ListTile(
                minVerticalPadding: 0,
                minLeadingWidth: 30,
                title: Text(
                  tripData.stops!.last.name ?? " ",
                  maxLines: 1,
                ),
                subtitle: Text(
                  DateFormat("dd MMMM, HH:mm", "RU").format(endTime).toString(),
                ),
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
