import 'dart:math';
import 'package:app_poezdka/bloc/trips_driver/trips_bloc.dart';
import 'package:app_poezdka/bloc/user_trips_driver/user_trips_driver_bloc.dart';
import 'package:app_poezdka/bloc/user_trips_passenger/user_trips_passenger_bloc.dart';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/const/images.dart';
import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/export/services.dart';
import 'package:app_poezdka/model/passenger_model.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/src/trips/components/trip_details_sheet.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/cached_image/user_image.dart';
import 'package:app_poezdka/widget/divider/verical_dividers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:scale_button/scale_button.dart';

class TripTile extends StatefulWidget {
  final TripModel trip;
  final bool last;
  const TripTile({Key? key, required this.trip, required this.last})
      : super(key: key);

  @override
  State<TripTile> createState() => _TripTileState();
}

class _TripTileState extends State<TripTile> {
  final userRepo = SecureStorage.instance;
  List<PassengerModel> passengers = [];

  int? userId;
  void initUserId() async {
    final id = await userRepo.getUserId();
    if (id != null) {
      setState(() {
        userId = int.parse(id);
      });
    }
  }

  @override
  void initState() {
    initUserId();
    check();
    passengers = widget.trip.passengers ?? [];
    super.initState();
  }

  bool stateCancel = false;
  bool stateCancelTrip = false;

  void check() async {
    final id = await userRepo.getUserId();
    if (widget.trip.passengers!.isNotEmpty && id != null) {
      for (var element in widget.trip.passengers!) {
        if (int.parse(id) == element.id) {
          stateCancel = true;
        }
      }
      if(widget.trip.owner!.id! != int.parse(id)) {
        stateCancelTrip = true;
      }
      setState(() {});
    }
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(BuildContext ctx) {
    final btmSheet = BottomSheetCall();
    final tripsBloc = BlocProvider.of<TripsBloc>(ctx, listen: false);
    final tripsDriverBloc =
        BlocProvider.of<UserTripsDriverBloc>(ctx, listen: false);
    final tripsPassangerBloc =
        BlocProvider.of<UserTripsPassengerBloc>(ctx, listen: false);
    final ownerImage = widget.trip.owner?.photo;
    return ScaleButton(
      bound: 0.05,
      duration: const Duration(milliseconds: 200),
      onTap: () {
        btmSheet.show(
          ctx,
          useRootNavigator: true,
          topRadius: const Radius.circular(50),
          child: TripDetailsSheet(
            trip: widget.trip,
            isMyTrips: true,
          ),
        );
      },
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                leading: UserCachedImage(
                  img: ownerImage,
                ),
                title: Text(
                  '${widget.trip.owner!.firstname!} ${widget.trip.owner!.lastname!}',
                  // "${widget.trip.owner!.firstname! + ' ' + widget.trip.owner!.lastname! ?? " Пользователь не найден"}",
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.trip.passenger!
                        ? 'Ищу поездку'
                        : 'Я Подвезу Вас'),
                    widget.trip.car == null
                        ? const SizedBox()
                        : Text(
                            widget.trip.car == null
                                ? ''
                                : "${widget.trip.car?.color ?? ''} ${widget.trip.car?.mark ?? ''} ${widget.trip.car?.model ?? ''}",
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                    // Text(
                    //   widget.trip.car == null
                    //   ? ''
                    //   : "${widget.trip.car?.color ?? ''} ${widget.trip.car?.mark ?? ''} ${widget.trip.car?.model ?? ''}",
                    //   maxLines: 1,
                    //   overflow: TextOverflow.clip,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 5, right: 5),
                    //   child: Container(
                    //     height: 5,
                    //     width: 5,
                    //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                    //     color: const Color.fromRGBO(191,212,228, 1))),
                    // ),
                    Text('${widget.trip.price} ₽')
                  ],
                ),
                trailing: SvgPicture.asset("$svgPath/archive-add.svg"),
              ),
              _trip(widget.trip),
              if (!widget.last)
                // passengers.any((element) => element.id == userId)
                stateCancel
                    ? FullWidthElevButton(
                        color: kPrimaryRed,
                        title: "Отменить бронь",
                        onPressed: () {
                          // final tripsBloc =
                          //   BlocProvider.of<TripsBloc>(context, listen: false);
                          // tripsBloc.add(DeletePassengerInTrip(widget.trip.tripId!,
                          //     widget.trip.tripId!));
                          //   // tripsBloc.add(DeleteTrip(widget.trip.tripId!));
                          //   // tripsDriverBloc.add(LoadUserTripsList());
                          //   Future.delayed(const Duration(seconds: 1), () => BlocProvider.of<UserTripsPassengerBloc>(context).add(LoadUserPassengerTripsList()));
                          tripsPassangerBloc
                              .add(CancelBookTrip(widget.trip.tripId!));
                          tripsBloc.add(LoadAllTripsList());
                          Future.delayed(const Duration(seconds: 1), () {
                            BlocProvider.of<UserTripsDriverBloc>(context)
                                .add(LoadUserTripsList());
                            // BlocProvider.of<UserTripsPassengerBloc>(context).add(LoadUserPassengerTripsList());
                            // setState(() {

                            // });
                          });
                        })
                    : const SizedBox(),
              if (!widget.last)
                // widget.trip.owner!.id == userId
                !stateCancelTrip
                    ? FullWidthElevButton(
                        title: "Отменить поездку",
                        onPressed: () {
                          tripsBloc.add(DeleteTrip(widget.trip.tripId!));
                          tripsDriverBloc.add(LoadUserTripsList());
                          Future.delayed(
                              const Duration(seconds: 1),
                              () => BlocProvider.of<UserTripsPassengerBloc>(
                                      context)
                                  .add(LoadUserPassengerTripsList()));
                        })
                    : const SizedBox()
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
                  tripData.stops != null && tripData.stops!.isNotEmpty
                      ? tripData.stops?.last.name ?? ""
                      : " ",
                  maxLines: 1,
                ),
                subtitle: Text(DateFormat("dd MMMM, HH:mm", "RU")
                    .format(endTime)
                    .toString()),
              ),
            ],
          ),
        ),
      ],
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
