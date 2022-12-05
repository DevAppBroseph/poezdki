import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:app_poezdka/bloc/chat/chat_bloc.dart';
import 'package:app_poezdka/bloc/chat/chat_builder.dart';
import 'package:app_poezdka/bloc/profile/profile_bloc.dart';
import 'package:app_poezdka/bloc/trips_driver/trips_bloc.dart';
import 'package:app_poezdka/bloc/user_trips_driver/user_trips_driver_bloc.dart';
import 'package:app_poezdka/bloc/user_trips_passenger/user_trips_passenger_bloc.dart';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/const/images.dart';
import 'package:app_poezdka/const/server/server_user.dart';
import 'package:app_poezdka/export/services.dart';
import 'package:app_poezdka/model/country_code.dart';
import 'package:app_poezdka/model/passenger_model.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/model/user_model.dart';
import 'package:app_poezdka/src/auth/signin.dart';
import 'package:app_poezdka/src/trips/components/book_trip.dart';
import 'package:app_poezdka/util/validation.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/cached_image/user_image.dart';
import 'package:app_poezdka/widget/dialog/error_dialog.dart';
import 'package:app_poezdka/widget/dialog/info_dialog.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:app_poezdka/widget/text_field/phone_text_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart'
    show LengthLimitingTextInputFormatter, rootBundle;

import 'trip_details_info.dart';

class TripDetailsSheet extends StatefulWidget {
  final TripModel trip;
  final bool isMyTrips;
  TripDetailsSheet({Key? key, required this.trip, this.isMyTrips = false})
      : super(key: key);

  @override
  State<TripDetailsSheet> createState() => _TripDetailsSheetState();
}

class _TripDetailsSheetState extends State<TripDetailsSheet> {
  final TextEditingController phoneController = TextEditingController();

  final streamController = StreamController<bool>();

  final btmSheet = BottomSheetCallAwait();

  CountryCode? countryCode;

  int maxLength = 10;

  String selectCode = '+7';

  void loadDB() async {
    String str = await rootBundle.loadString('assets/phone/code_phone.json');
    countryCode = CountryCode.fromJson(json.decode(str));
  }

  @override
  void initState() {
    loadDB();
    super.initState();
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

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
        if (widget.isMyTrips)
          if (widget.trip.passengers!.isNotEmpty) _passengerInfo(),
        if (widget.isMyTrips)
          if (widget.trip.passengers!.isNotEmpty) _div(),
        // _rideComment(),
        if (!widget.isMyTrips) _tripButtons(context),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }

  Widget _tripButtons(context) {
    BlocProvider.of<UserTripsPassengerBloc>(context).add(LoadUserPassengerTripsList());
    return Row(
      children: [
        widget.trip.package!
            ? Expanded(
                child: FullWidthElevButton(
                  onPressed: () => bookPackage(context),
                  title: "Передать посылку",
                  titleStyle:
                      const TextStyle(fontSize: 13, color: Colors.white),
                ),
              )
            : const SizedBox(),
        BlocBuilder<UserTripsDriverBloc, UserTripsDriverState>(
            builder: (context, state) {
          List<List<TripModel>> tripsModelsDriver = BlocProvider.of<UserTripsDriverBloc>(context).tripsModel;
          List<List<TripModel>> tripsModelPass = BlocProvider.of<UserTripsPassengerBloc>(context).tripsModel;

          List<List<TripModel>> list = [];

          list.addAll(tripsModelsDriver);
          list.addAll(tripsModelPass);
          // if (state is UserTripsDriverLoaded) {
          //   tripsModels.addAll(state.trips);
          // }
          return Expanded(
            child: FullWidthElevButton(
              onPressed: () => bookTrip(context, tripsModelPass),
              title: "Забронировать",
              titleStyle: const TextStyle(fontSize: 13, color: Colors.white),
            ),
          );
        }),
      ],
    );
  }

  // Widget _rideComment() {
  Widget _tripData() {
    return RideDetailsTrip(
      tripData: widget.trip,
    );
  }

  Widget _price() {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: RichText(
          text: TextSpan(
              text: widget.trip.price.toString(),
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
      'Перевозка багажа': widget.trip.package,
      '2 места на заднем сиденье': widget.trip.twoPlacesInBehind,
      'Есть детское кресло': widget.trip.babyChair,
      'Можно с животными': widget.trip.animals,
      'Кондиционер': widget.trip.conditioner,
      'Можно курить': widget.trip.smoke
    };

    return Column(
      children: [
        ListTile(
          title: const Text("Автомобиль"),
          trailing: SizedBox(
            width: 150,
            child: Text(
              "${widget.trip.car?.mark ?? ""} ${widget.trip.car?.model ?? ""} ${widget.trip.car?.color ?? ""} ",
              maxLines: 2,
              overflow: TextOverflow.clip,
            ),
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
    if (widget.trip.passengers!.any((element) => element.seat!.contains(0))) {
      if (widget.trip.passengers!.last.id != 0) {
        widget.trip.passengers!.add(PassengerModel(
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
              itemCount: widget.trip.passengers?.length,
              itemBuilder: (context, int index) {
                if (widget.trip.owner!.id ==
                        widget.trip.passengers![index].id ||
                    widget.trip.passengers![index].id == 0) {
                  return const SizedBox();
                }

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
                      onTap: () async {
                        // final tripsBloc =
                        //     BlocProvider.of<TripsBloc>(context, listen: false);
                        // tripsBloc.add(DeletePassengerInTrip(widget.trip.tripId!,
                        //     widget.trip.passengers![index].id!));

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
                            img: widget.trip.passengers![index].photo,
                          ),
                          title: Text(
                            widget.trip.passengers![index].firstname!,
                            style: const TextStyle(
                                fontFamily: '.SF Pro Display', fontSize: 15),
                          ),
                          subtitle: widget.trip.passengers![index].id != 0
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    widget.trip.car == null
                                        ? const Text('водитель')
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _getSeat(
                                                  widget.trip.passengers![index]
                                                      .seat!
                                                      .where((element) =>
                                                          element != 0)
                                                      .length,
                                                ),
                                                style: const TextStyle(
                                                  fontFamily: '.SF Pro Display',
                                                ),
                                              ),
                                              Text(
                                                widget.trip.passengers![index]
                                                        .seat!
                                                        .contains(0)
                                                    ? 'посылка'
                                                    : '',
                                                style: const TextStyle(
                                                    fontFamily:
                                                        '.SF Pro Display',
                                                    fontSize: 15),
                                              )
                                            ],
                                          )
                                  ],
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
          height: 300,
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
                        chatToDriver(context,
                            id: widget.trip.passengers![index].id);
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
                        final passengers = widget.trip.passengers;
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
                                      BlocProvider.of<TripsBloc>(context).add(
                                        AddReview(
                                          context,
                                          widget.trip.passengers![index].id!,
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
                SizedBox(
                  height: 65,
                  child: Material(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () async {
                        final url =
                            "tel:${widget.trip.passengers![index].phoneNumber}";
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Center(
                        child: ListTile(
                          title: const Text('Позвонить'),
                          trailing:
                              SvgPicture.asset("$svgPath/call-calling.svg"),
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
                        final tripsBloc =
                            BlocProvider.of<TripsBloc>(context, listen: false);
                        tripsBloc.add(DeletePassengerInTrip(widget.trip.tripId!,
                            widget.trip.passengers![index].id!));
                        Navigator.of(context)
                          ..pop()
                          ..pop();
                        BlocProvider.of<UserTripsDriverBloc>(context)
                            .add(LoadUserTripsList());
                      },
                      child: const Center(
                        child: ListTile(
                          title: Text('Удалить'),
                          trailing: Icon(
                            Icons.delete,
                            color: Colors.red,
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
          img: widget.trip.owner?.photo,
        ),
        title: Text(
          (widget.trip.owner?.firstname != null
                  ? widget.trip.owner!.firstname!
                  : '') +
              ' ' +
              (widget.trip.owner?.lastname != null
                  ? widget.trip.owner!.lastname!
                  : ''),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.trip.owner?.phone != null
                ? IconButton(
                    onPressed: () => callToDriver(context),
                    icon: SvgPicture.asset("$svgPath/call-calling.svg"),
                  )
                : const SizedBox(),
            IconButton(
              onPressed: () => chatToDriver(context,
                  id: widget.trip.owner?.id,
                  phone: widget.trip.owner!.phoneNumber),
              icon: SvgPicture.asset("$svgPath/messages-2.svg"),
            ),
            IconButton(
              onPressed: share,
              icon: const Icon(Icons.ios_share_sharp, color: kPrimaryColor),
            )
          ],
        ),
      ),
    );
  }

  void share() async {
    ByteData bytes = await rootBundle.load('assets/img/label.png');
    Uint8List image =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/image.jpg';
    File(path).writeAsBytesSync(image);

    DateTime date = DateTime.fromMicrosecondsSinceEpoch(widget.trip.timeStart!);
    var format = DateFormat("yyyy/MM/dd hh:mm");
    var dateString = format.format(date);

    String linkApp = Platform.isAndroid
        ? 'https://play.google.com/store/apps/details?id=com.broseph.poezdka'
        : 'https://apps.apple.com/by/app/%D0%BF%D0%BE%D0%B5%D0%B7%D0%B4%D0%BA%D0%B0-%D0%B1%D1%80%D0%BE%D0%BD%D0%B8%D1%80%D1%83%D0%B9-%D0%BF%D0%BE%D0%B5%D0%B7%D0%B4%D0%BA%D1%83/id1640484502';
    Share.shareFiles([path],
        text:
            '${widget.trip.departure?.name}-${widget.trip.stops!.last.name}\n$linkApp\n$dateString');
  }

  Widget _div() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Divider(),
    );
  }

  void bookPackage(context) async {
    BlocProvider.of<TripsBloc>(context, listen: false)
        .add(BookThisPackage(context, const [], widget.trip.tripId!));
  }

  void bookTrip(context, List<List<TripModel>> tripsModels) async {
    final tripBloc = BlocProvider.of<TripsBloc>(context, listen: false);
    final userRepo = SecureStorage.instance;
    final token = await userRepo.getToken();
    if (token != null) {
      // if (passengers!.any((p) => p.id == int.parse(userId!))) {
      //   null;
      // } else {
      if (widget.trip.car == null) {
        final state = BlocProvider.of<ProfileBloc>(context).state;
        if (state is ProfileLoaded) {
          if (state.user.phone == null || state.user.phone == '') {
            phoneController.text = '';
            InfoDialog().show(
                buttonTitle: 'Подтвердить',
                title: 'Введите ваш номер',
                children: [
                  StreamBuilder<bool>(
                      initialData: true,
                      stream: streamController.stream,
                      builder: (context, snapshot) {
                        return PhoneTextField(
                            hintText: 'Телефон',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () async {
                                  Country? select = await btmSheet.wait(
                                    context,
                                    useRootNavigator: true,
                                    child: Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: countryCode!.country.length,
                                        itemBuilder: ((context, index) {
                                          return MaterialButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(
                                                  countryCode!.country[index]);
                                            },
                                            child: SizedBox(
                                              height: 30,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      countryCode!
                                                          .country[index].name!,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    countryCode!.country[index]
                                                        .dialCode!,
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  );
                                  if (select != null) {
                                    maxLength = int.parse(select.lengthPhone!) -
                                        select.dialCode!.length;
                                    selectCode = select.dialCode!;
                                    streamController.add(true);
                                  }
                                },
                                child: SizedBox(
                                  width: 60,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      selectCode,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            controller: phoneController,
                            textInputType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(maxLength)
                            ],
                            validateFunction: Validations.validatePhone);
                      })
                ],
                onPressed: () {
                  final validate =
                      Validations.validatePhone(phoneController.text);
                  if (validate == null) {
                    final dio = Dio();
                    dio.options.headers["Authorization"] = state.user.token;
                    dio.put(addPhone, data: {
                      'phone_number': selectCode + phoneController.text
                    }).then((value) {
                      _editUser(state, context);
                      // SmartDialog.dismiss();
                    });
                  }
                });
          } else {
            tripBloc.add(BookThisTrip(context, const [], widget.trip.tripId!));
          }
        }
      } else {
        bool statebutton = false;

        for (var element in tripsModels) {
          for (var element1 in element) {
            print('object ${element1.tripId} ${widget.trip.tripId}');
            if (element1.tripId == widget.trip.tripId) {
              // print('object ${element1.tripId} ${widget.trip.tripId}');
              statebutton = true;
              break;
            }
          }
        }
        if (statebutton) {
          InfoDialog().show(
            height: 100,
            buttonTitle: 'А, ой, точняк',
            title: 'Невозможно забронировать!',
            description: 'Вы уже забронировали место в данной поездке',
            children: [],
          );
        } else {
          InfoDialog().show(
            height: 100,
            buttonTitle: 'Хорошо',
            title: 'Помните!',
            description:
                'Оплату за поездку необходимо производить только после того как услуга будет выполнена.',
            children: [],
            onPressed: () async {
              await SmartDialog.dismiss();
              // print(
              //     'object ${widget.trip.car!.countOfPassengers} ${widget.trip.car!.countOfPassengers}');
              // print('object ${widget.trip.passengers!.length + 1} ${widget.trip.tripId!}');
              if (widget.trip.car!.countOfPassengers! > 4) {
                tripBloc.add(
                  BookThisTrip(
                    context,
                    [widget.trip.bronSeat],
                    widget.trip.tripId!,
                  ),
                );
              } else {
                await pushNewScreen(
                  context,
                  screen: BookTrip(
                    tripData: widget.trip,
                  ),
                );
                Navigator.pop(context);
                BlocProvider.of<UserTripsPassengerBloc>(context)
                    .add(LoadUserPassengerTripsList());
              }
            },
          );
        }
      }
    } else {
      pushNewScreen(context, withNavBar: false, screen: const SignInScreen());
    }
  }

  void _editUser(ProfileLoaded state, context) {
    BlocProvider.of<ProfileBloc>(context).add(
      UpdateProfile(
        UserModel(
          photo: state.user.photo,
          firstname: state.user.firstname,
          email: state.user.email,
          lastname: state.user.lastname,
          phone: selectCode + phoneController.text,
          gender: state.user.gender,
          birth: state.user.birth,
          cars: state.user.cars,
        ),
        // context,
      ),
    );
  }

  void callToDriver(context) async {
    final userRepo = SecureStorage.instance;
    final token = await userRepo.getToken();
    if (token != null) {
      // final passengers = trip.passengers;
      // if (passengers!.any((p) => p.id == int.parse(userId!))) {
      launchUrl(Uri(scheme: 'tel', path: '${widget.trip.owner?.phone}'));
      // } else {
      // ErrorDialogs()
      // .showError("Только пассажиры могут связаться с водителем.");
      // }
    } else {
      pushNewScreen(context, withNavBar: false, screen: const SignInScreen());
    }
  }

  void chatToDriver(context, {int? id, String? phone}) async {
    final userRepo = SecureStorage.instance;
    final token = await userRepo.getToken();
    final userId = await userRepo.getUserId();
    if (token != null) {
      if (id == null) {
        final passengers = widget.trip.passengers;
        if (passengers!.any((p) => p.id == int.parse(userId!))) {
          BlocProvider.of<ChatBloc>(context).testController.add([]);
          pushNewScreen(
            context,
            withNavBar: false,
            screen: ChatsBuilder(
              ownerId: widget.trip.owner!.id!,
              senderId: int.parse(userId!),
              token: token,
              phone: phone!,
              receiverId: widget.trip.owner!.id!,
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
              phone: phone,
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
