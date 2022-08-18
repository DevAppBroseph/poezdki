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

class TripTileDefault extends StatelessWidget {
  final TripModel trip;
  const TripTileDefault({Key? key, required this.trip}) : super(key: key);

  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(BuildContext ctx) {
    final ownerImage = trip.owner?.photo;
    final btmSheet = BottomSheetCall();
    return InkWell(
      onTap: () => btmSheet.show(
        ctx,
        useRootNavigator: true,
        topRadius: const Radius.circular(50),
        child: TripDetailsSheet(
          trip: trip,
        ),
      ),
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
                leading: UserCachedImage(
                  img: ownerImage,
                ),
                title: Text(
                  '${trip.owner!.firstname!} ${trip.owner!.lastname!}',
                  // "${((trip.owner!.firstname! + ' ' + trip.owner!.lastname!)) ?? " Пользователь не найден"}",
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
                subtitle: Text(
                  "${trip.price} ₽",
                  maxLines: 1,
                  overflow: TextOverflow.clip,
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
          )),
    );
  }

  Widget _trip(TripModel? tripData) {
    final startTime = DateTime.fromMicrosecondsSinceEpoch(tripData!.timeStart!);
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
