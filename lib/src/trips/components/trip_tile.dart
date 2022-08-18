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

class TripTile extends StatefulWidget {
  final TripModel trip;
  bool last;
  TripTile({Key? key, required this.trip, required this.last})
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
    passengers = widget.trip.passengers ?? [];
    super.initState();
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
    return InkWell(
      onTap: () {
        btmSheet.show(
          ctx,
          useRootNavigator: true,
          topRadius: const Radius.circular(50),
          child: TripDetailsSheet(
            trip: widget.trip,
          ),
        );
      },
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
                  '${widget.trip.owner!.firstname!} ${widget.trip.owner!.lastname!}',
                  // "${widget.trip.owner!.firstname! + ' ' + widget.trip.owner!.lastname! ?? " Пользователь не найден"}",
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
                subtitle: Text(
                  "${widget.trip.car?.color ?? ''} ${widget.trip.car?.mark ?? ''} ${widget.trip.car?.model ?? ''} ${widget.trip.price} ₽",
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
                trailing: SvgPicture.asset("$svgPath/archive-add.svg"),
              ),
              _trip(widget.trip),
              passengers.any((element) => element.id == userId)
                  ? FullWidthElevButton(
                      color: kPrimaryRed,
                      title: "Отменить бронь",
                      onPressed: () {
                        tripsPassangerBloc
                            .add(CancelBookTrip(widget.trip.tripId!));
                        tripsBloc.add(LoadAllTripsList());
                      },
                    )
                  : const SizedBox(),
              if (!widget.last)
                widget.trip.owner!.id == userId
                    ? FullWidthElevButton(
                        title: "Отменить поездку",
                        onPressed: () {
                          tripsBloc.add(DeleteTrip(widget.trip.tripId!));
                          tripsBloc.add(LoadAllTripsList());
                          tripsDriverBloc.add(LoadUserTripsList());
                        },
                      )
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
