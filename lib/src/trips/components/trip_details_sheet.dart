import 'package:app_poezdka/bloc/chat/chat_bloc.dart';
import 'package:app_poezdka/bloc/chat/chat_builder.dart';
import 'package:app_poezdka/bloc/trips_driver/trips_bloc.dart';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/const/images.dart';
import 'package:app_poezdka/export/services.dart';
import 'package:app_poezdka/model/passenger_model.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/src/auth/signin.dart';
import 'package:app_poezdka/src/chat/chat_screen.dart';
import 'package:app_poezdka/src/trips/components/book_trip.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/cached_image/user_image.dart';
import 'package:app_poezdka/widget/dialog/error_dialog.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';

import 'trip_details_info.dart';

class TripDetailsSheet extends StatelessWidget {
  final TripModel trip;
  bool isMyTrips;
  TripDetailsSheet({Key? key, required this.trip, this.isMyTrips = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheetChildren(
      children: [
        _ownerInfo(context),
        _price(),
        _tripData(),
        _div(),
        _rideInfo(),
        _div(),
        if (isMyTrips)
          if (trip.passengers!.isNotEmpty) _passengerInfo(),
        if (isMyTrips)
          if (trip.passengers!.isNotEmpty) _div(),
        // _rideComment(),
        if (!isMyTrips) _tripButtons(context),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }

  Widget _tripButtons(context) {
    return Row(
      children: [
        trip.package!
            ? Expanded(
                child: FullWidthElevButton(
                  onPressed: () => bookPackage(context),
                  title: "Передать посылку",
                  titleStyle:
                      const TextStyle(fontSize: 13, color: Colors.white),
                ),
              )
            : const SizedBox(),
        Expanded(
            child: FullWidthElevButton(
          onPressed: () => bookTrip(context),
          title: "Забронировать",
          titleStyle: const TextStyle(fontSize: 13, color: Colors.white),
        ))
      ],
    );
  }

  // Widget _rideComment() {
  //   return const ListTile(
  //     title: Text(loremIpsum),
  //   );
  // }

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

  Widget _passengerInfo() {
    if (trip.passengers!.any((element) => element.seat!.contains(0))) {
      if (trip.passengers!.last.id != 0) {
        trip.passengers!.add(PassengerModel(
          id: 0,
          phone: '',
          firstname: '',
          lastname: '',
          seat: [0],
        ));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //TODO доделать кол-во доступных мест

        // if (trip.maxSeats != null)
        // Padding(
        //   padding: const EdgeInsets.only(left: 15, bottom: 5, top: 5),
        //   child: Text(
        //     'Пассажиры 3/${trip.maxSeats}',
        //     style: const TextStyle(
        //       fontSize: 16,
        //       color: Colors.grey,
        //       fontWeight: FontWeight.w600,
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 100,
          width: double.infinity,
          child: ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              // padding: EdgeInsets.all(5),
              itemCount: trip.passengers?.length,
              itemBuilder: (context, int index) {
                return Container(
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 10,
                        spreadRadius: 4,
                        color: Color.fromRGBO(26, 42, 97, 0.06),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  height: 62,
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        final btmSheet = BottomSheetCall();
                        btmSheet.show(
                          topRadius: const Radius.circular(50),
                          context,
                          child: _passangerBottom(context, index),
                        );
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Center(
                        child: ListTile(
                          leading: UserCachedImage(
                            img: trip.passengers![index].photo,
                          ),
                          title: Text(
                            trip.passengers![index].id != 0
                                ? trip.passengers![index].firstname! +
                                    ' ' +
                                    trip.passengers![index].lastname!
                                : '1 посылка',
                            style: const TextStyle(
                                fontFamily: '.SF Pro Display', fontSize: 15),
                          ),
                          subtitle: trip.passengers![index].id != 0
                              ? Text(
                                  _getSeat(
                                    trip.passengers![index].seat!
                                        .where((element) => element != 0)
                                        .length,
                                  ),
                                  style: const TextStyle(
                                    fontFamily: '.SF Pro Display',
                                  ),
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  BottomSheetChildren _passangerBottom(BuildContext context, int index) {
    return BottomSheetChildren(
      children: [
        SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                SizedBox(
                  height: 65,
                  child: Material(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        chatToDriver(context, id: trip.passengers![index].id);
                      },
                      child: Center(
                        child: ListTile(
                          title: const Text('Написать в чат'),
                          trailing: SvgPicture.asset(
                            "$svgPath/messages-2.svg",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 65,
                  child: Material(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () async {
                        final userRepo = SecureStorage.instance;
                        final passengers = trip.passengers;
                        final userId = await userRepo.getUserId();
                        if (passengers?[index].id != int.parse(userId!)) {
                          Navigator.pop(context);
                          final btmSheet = BottomSheetCall();
                          var reviewController = TextEditingController();
                          var ratingCount = 3;
                          btmSheet.show(
                            topRadius: const Radius.circular(50),
                            context,
                            expand: true,
                            child: SizedBox(
                              height: 250,
                              child: BottomSheetChildren(
                                children: [
                                  const SizedBox(height: 30),
                                  RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      ratingCount = rating.toInt();
                                    },
                                  ),
                                  const SizedBox(height: 30),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: KFormField(
                                      hintText: 'Оставьте отзыв',
                                      textEditingController: reviewController,
                                    ),
                                  ),
                                  FullWidthElevButton(
                                    title: 'Отправить',
                                    onPressed: () {
                                      print(ratingCount);
                                      print(reviewController.text);
                                      BlocProvider.of<TripsBloc>(context).add(
                                        AddReview(
                                          context,
                                          trip.passengers![index].id!,
                                          reviewController.text,
                                          ratingCount,
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                        } else {
                          ErrorDialogs()
                              .showError("Нельзя оставить отзыв себе.");
                        }
                      },
                      child: Center(
                        child: ListTile(
                          title: const Text('Оставить отзыв'),
                          trailing: Image.asset(
                            "assets/img/star.png",
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getSeat(int count) {
    var n = count;
    n %= 100;
    if (n >= 5 && n <= 20) {
      return '$count мест';
    }
    n %= 10;
    if (n == 1) {
      return '$count место';
    }
    if (n >= 2 && n <= 4) {
      return '$count места';
    }
    return '$count мест';
  }

  Widget _ownerInfo(context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: kPrimaryWhite, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: UserCachedImage(
          img: trip.owner?.photo,
        ),
        title: Text(
          (trip.owner?.firstname != null ? trip.owner!.firstname! : '') +
              ' ' +
              (trip.owner?.lastname != null ? trip.owner!.lastname! : ''),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            trip.owner?.phone != null
                ? IconButton(
                    onPressed: () => callToDriver(context),
                    icon: SvgPicture.asset("$svgPath/call-calling.svg"),
                  )
                : const SizedBox(),
            IconButton(
              onPressed: () => chatToDriver(context, id: trip.owner?.id),
              icon: SvgPicture.asset("$svgPath/messages-2.svg"),
            )
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

  void bookPackage(context) async {
    final userRepo = SecureStorage.instance;
    final token = await userRepo.getToken();
    final userId = await userRepo.getUserId();
    final passengers = trip.passengers;
    final tripBloc = BlocProvider.of<TripsBloc>(context, listen: false)
      ..add(BookThisPackage(context, [], trip.tripId!));
  }

  void bookTrip(context) async {
    final userRepo = SecureStorage.instance;
    final token = await userRepo.getToken();
    final userId = await userRepo.getUserId();
    final passengers = trip.passengers;
    if (token != null) {
      // if (passengers!.any((p) => p.id == int.parse(userId!))) {
      //   null;
      // } else {
      pushNewScreen(
        context,
        screen: BookTrip(
          tripData: trip,
        ),
      );
      // }
    } else {
      pushNewScreen(context, withNavBar: false, screen: const SignInScreen());
    }
  }

  void callToDriver(context) async {
    final userRepo = SecureStorage.instance;
    final token = await userRepo.getToken();
    final userId = await userRepo.getUserId();
    if (token != null) {
      final passengers = trip.passengers;
      if (passengers!.any((p) => p.id == int.parse(userId!))) {
        launchUrl(Uri(scheme: 'tel', path: '${trip.owner?.phone}'));
      } else {
        ErrorDialogs()
            .showError("Только пассажиры могут связаться с водителем.");
      }
    } else {
      pushNewScreen(context, withNavBar: false, screen: const SignInScreen());
    }
  }

  void chatToDriver(context, {int? id}) async {
    final userRepo = SecureStorage.instance;
    final token = await userRepo.getToken();
    final userId = await userRepo.getUserId();
    if (token != null) {
      if (id == null) {
        final passengers = trip.passengers;
        if (passengers!.any((p) => p.id == int.parse(userId!))) {
          BlocProvider.of<ChatBloc>(context).testController.add([]);
          pushNewScreen(
            context,
            withNavBar: false,
            screen: ChatsBuilder(
              ownerId: trip.owner!.id!,
              senderId: int.parse(userId!),
              token: token,
              receiverId: trip.owner!.id!,
            ),
          );
        } else {
          ErrorDialogs()
              .showError("Только пассажиры могут связаться с водителем.");
        }
      } else {
        if (int.parse(userId!) != id) {
          pushNewScreen(
            context,
            withNavBar: false,
            screen: ChatsBuilder(
              ownerId: id,
              senderId: int.parse(userId),
              token: token,
              receiverId: id,
            ),
          );
        } else {
          ErrorDialogs()
              .showError("Связаться можно только с другими пользователями.");
        }
      }
    } else {
      pushNewScreen(context, withNavBar: false, screen: const SignInScreen());
    }
  }
}
