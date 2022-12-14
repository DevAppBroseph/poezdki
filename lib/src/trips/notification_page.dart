import 'dart:convert';
import 'dart:io';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/service/local/secure_storage.dart';
import 'package:app_poezdka/src/rides/components/waypoint.dart';
import 'package:app_poezdka/src/rides/components/waypoints.dart';
import 'package:app_poezdka/src/trips/components/pick_city.dart';
import 'package:app_poezdka/src/trips/components/search_trip_filter.dart';
import 'package:app_poezdka/widget/bottom_sheet/btm_builder.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:app_poezdka/widget/text_field/form_location_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationModel {
  int? id;
  String? departure;
  String? destination;
  int? fromDot;
  int? toDot;

  NotificationModel(
    this.id,
    this.departure,
    this.destination,
    this.fromDot,
    this.toDot,
  );

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    int? id = json['id'];
    String? departure = json['from_dot'];
    String? destination = json['to_dot'];
    int? fromDot = json['time_from'];
    int? toDot = json['time_to'];
    return NotificationModel(id, departure, destination, fromDot, toDot);
  }
}

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final btmSheet = BottomSheetCallAwait();
  Departure? from;
  Departure? to;

  final TextEditingController startWay = TextEditingController();
  final TextEditingController endWay = TextEditingController();

  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  DateTime? timeMilisecondStart;
  DateTime? timeMilisecondEnd;

  List<NotificationModel> notifications = [];

  @override
  void initState() {
    super.initState();
    allNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: kPrimaryWhite,
        child: NestedScrollView(
          headerSliverBuilder: (context, bool inner) {
            return [
              SliverAppBar(
                title: const Text('Уведомления'),
                bottom: _bottomFilter(),
              )
            ];
          },
          body: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 30),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Container(
                  // height: 80,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.notifications,
                        size: 27,
                        color: kPrimaryColor,
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    notifications[index].departure!,
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                    DateFormat("dd MMMM, HH:mm", 'RU')
                                        .format(
                                            DateTime.fromMicrosecondsSinceEpoch(
                                                notifications[index].fromDot!))
                                        .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    notifications[index].destination!,
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                    DateFormat("dd MMMM, HH:mm", 'RU')
                                        .format(
                                            DateTime.fromMicrosecondsSinceEpoch(
                                                notifications[index].toDot!))
                                        .toString(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  PreferredSize _bottomFilter() {
    return PreferredSize(
      preferredSize: const Size(200, 355),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: Column(
              children: [
                WayPointField(
                  type: WaypointType.start,
                  textField: GestureDetector(
                    onTap: () => pickDestinition(
                      context,
                      startWay,
                      from,
                      "Откуда едем?",
                      (destination) {
                        setState(() {
                          from = destination;
                        });
                      },
                    ),
                    child: LocationField(
                      startWay: startWay,
                      hintText: 'Откуда',
                      icon: 'assets/img/gps.svg',
                      iconClear: startWay.text.isNotEmpty
                          ? IconButton(
                              padding: const EdgeInsets.only(right: 0, top: 5),
                              alignment: Alignment.centerRight,
                              onPressed: () {
                                setState(() {
                                  from = null;
                                  startWay.clear();
                                });
                              },
                              icon: const Icon(
                                CupertinoIcons.clear_circled,
                                size: 18,
                                color: kPrimaryDarkGrey,
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ),
                ),
                WayPointField(
                  type: WaypointType.empty,
                  textField: SizedBox(
                    child: Row(
                      children: [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: GestureDetector(
                            onTap: () {
                              final temp = from;
                              from = to;
                              to = temp;

                              startWay.text = from != null ? from!.name! : '';
                              endWay.text = to != null ? to!.name! : '';

                              setState(() {});
                            },
                            child: const Icon(
                              Icons.swap_vert_rounded,
                              color: kPrimaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                WayPointField(
                  type: WaypointType.start,
                  textField: GestureDetector(
                    onTap: () => pickDestinition(
                        context, endWay, to, "Куда едем?", (destination) {
                      setState(() {
                        to = destination;
                      });
                    }),
                    child: LocationField(
                      startWay: endWay,
                      hintText: 'Куда',
                      icon: 'assets/img/gps.svg',
                      iconClear: endWay.text.isNotEmpty
                          ? IconButton(
                              padding: const EdgeInsets.only(right: 0, top: 5),
                              alignment: Alignment.centerRight,
                              onPressed: () {
                                setState(() {
                                  to = null;
                                  endWay.clear();
                                });
                              },
                              icon: const Icon(
                                CupertinoIcons.clear_circled,
                                size: 18,
                                color: kPrimaryDarkGrey,
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        // const Expanded(child: Text('С:   ')),
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            onTap: () => funcDate(TypeDate.start),
                            child: KFormField(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 20),
                              enabled: false,
                              hintText: DateFormat('dd.MM.yyyy HH:mm')
                                  .format(DateTime.now()),
                              textEditingController: startDate,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: kPrimaryColor,
                          ),
                        ),
                        // const SizedBox(width: 20),
                        // const Expanded(child: Text('По:   ')),
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            onTap: () => funcDate(TypeDate.end),
                            child: KFormField(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 20,
                              ),
                              enabled: false,
                              hintText: DateFormat('dd.MM.yyyy HH:mm')
                                  .format(DateTime.now()),
                              textEditingController: endDate,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FullWidthElevButton(
                  title: 'Поставить уведомление',
                  onPressed: setNotification,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void pickDestinition(
      context,
      TextEditingController contoller,
      Departure? city,
      String title,
      Function(Departure? destination) onChanged) async {
    final Departure? destinition = await btmSheet.wait(context,
        useRootNavigator: true,
        child: PickCity(
          title: title,
        ));
    if (destinition != null) {
      setState(() {
        contoller.text = destinition.name!;
        city = destinition;
        onChanged(destinition);
      });
    }
  }

  void funcDate(TypeDate typeDate) async {
    if (Platform.isAndroid) {
      final value = await showDialog(
          context: context,
          builder: ((context) {
            return DatePickerDialog(
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2030),
            );
          }));
      if (value != null) {
        final TimeOfDay? timePicked = await showTimePicker(
            context: context,
            initialTime: TimeOfDay(
              hour: TimeOfDay.now().hour,
              minute: TimeOfDay.now().minute,
            ));

        if (typeDate == TypeDate.start) {
          final DateTime temp = DateTime(
            value.year,
            value.month,
            value.day,
            timePicked != null ? timePicked.hour : 0,
            timePicked != null ? timePicked.minute : 0,
          );
          timeMilisecondStart = temp;
          startDate.text = DateFormat('dd.MM.yyyy HH:mm').format(temp);
        } else {
          final DateTime temp = DateTime(
            value.year,
            value.month,
            value.day,
            timePicked != null ? timePicked.hour : 0,
            timePicked != null ? timePicked.minute : 0,
          );
          timeMilisecondEnd = temp;
          endDate.text = DateFormat('dd.MM.yyyy HH:mm').format(temp);
        }
      }
    } else {
      await showDialog(
        barrierDismissible: true,
        useSafeArea: false,
        barrierColor: Colors.transparent,
        context: context,
        builder: ((context) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.grey.shade300)),
                          child: const Text('Готово'),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 200,
                    color: Colors.grey[200],
                    child: CupertinoDatePicker(
                      use24hFormat: true,
                      onDateTimeChanged: (value) {
                        if (typeDate == TypeDate.start) {
                          timeMilisecondStart = value;
                          startDate.text =
                              DateFormat('dd.MM.yyyy HH:mm').format(value);
                        } else {
                          timeMilisecondEnd = value;
                          endDate.text =
                              DateFormat('dd.MM.yyyy HH:mm').format(value);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      );
    }
  }

  void allNotification() async {
    Response response;
    var dio = Dio();
    final token = await SecureStorage.instance.getToken();

    try {
      response = await dio.get(
        'http://194.87.145.140/trips/get_trip_nots',
        options: Options(
          headers: {"Authorization": token},
        ),
      );

      List<NotificationModel> notifModel = [];

      if (response.statusCode == 200) {
        for (var element in response.data) {
          notifModel.add(NotificationModel.fromJson(element));
        }
        notifications.clear();
        notifications.addAll(notifModel);
        setState(() {});
      }
    } catch (e) {
      return null;
    }
  }

  void setNotification() async {
    if (startWay.text.isEmpty ||
        endWay.text.isEmpty ||
        startDate.text.isEmpty ||
        endDate.text.isEmpty) return;
    final body = {
      "departure": {"name": startWay.text},
      "destination": {"name": endWay.text},
      "time_from": timeMilisecondStart!.microsecondsSinceEpoch,
      "time_to": timeMilisecondEnd!.microsecondsSinceEpoch
    };

    Response response;
    var dio = Dio();
    final token = await SecureStorage.instance.getToken();

    try {
      response = await dio.post(
        'http://194.87.145.140/trips/add_trip_not',
        data: json.encode(body),
        options: Options(
          headers: {"Authorization": token},
        ),
      );

      if (response.statusCode == 200) allNotification();
    } catch (e) {
      return null;
    }
  }
}
