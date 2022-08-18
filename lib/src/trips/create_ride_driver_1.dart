import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/src/rides/components/waypoints.dart';
import 'package:app_poezdka/widget/dialog/info_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../widget/bottom_sheet/btm_builder.dart';
import '../../widget/button/full_width_elevated_button.dart';
import 'components/pick_car.dart';
import 'create_ride_driver_2.dart';
import 'components/pick_city.dart';

class CreateRideDriver extends StatefulWidget {
  const CreateRideDriver({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateRideDriver> createState() => _CreateRideDriverState();
}

class _CreateRideDriverState extends State<CreateRideDriver> {
  final btmSheet = BottomSheetCallAwait();
  final TextEditingController startWay = TextEditingController();
  final TextEditingController endWay = TextEditingController();
  List<TextEditingController> _midwayControllers = [];
  var midWays = <TextEditingController>[];
  Departure? from;
  Departure? to;
  List<Departure> stopsList = [];
  DateTime? date;
  TimeOfDay? time;
  Car? selectedCar;

  @override
  Widget build(BuildContext context) {
    const TextStyle pickerStyle =
        TextStyle(color: Colors.grey, fontWeight: FontWeight.w300);
    const TextStyle carStyle =
        TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w400);

    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WayPoints(
                  pickDestinitionFrom: () => pickDestinition(
                    startWay,
                    true,
                    "Откуда поедем?",
                    null,
                  ),
                  onTap: (index) => pickDestinition(
                    null,
                    false,
                    "Куда заедем?",
                    index,
                  ),
                  pickDestinitionTo: () => pickDestinition(
                    endWay,
                    false,
                    "Куда едем?",
                    null,
                  ),
                  pickDestinitionStops: () {},
                  startWay: startWay,
                  endWay: endWay,
                  midWays: midWays,
                  midwayControllers: _midwayControllers,
                  onAdd: () {
                    setState(() {
                      midWays.add(TextEditingController());
                      _midwayControllers.add(TextEditingController());
                    });
                  },
                  onDelete: () {},
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text("Дата"),
                          trailing: TextButton(
                              onPressed: () => _pickDate(),
                              child: Text(
                                date != null
                                    ? DateFormat.yMMMMd('ru').format(date!)
                                    : "Укажите дату",
                                style: pickerStyle,
                              )),
                        ),
                        ListTile(
                          title: const Text("Время выезда"),
                          trailing: TextButton(
                              onPressed: () => _pickTime(),
                              child: Text(
                                time != null
                                    ? "${time!.hour.toString().padLeft(2, '0')}:${time!.minute.toString().padLeft(2, '0')}"
                                    : "Укажите время",
                                style: pickerStyle,
                              )),
                        ),
                        ListTile(
                          title: const Text("Автомобиль"),
                          trailing: TextButton(
                            onPressed: () => pickCar(context),
                            child: selectedCar != null
                                ? Text(
                                    "${selectedCar!.mark} ${selectedCar!.model} ${selectedCar!.color}",
                                    style: carStyle,
                                  )
                                : const Text(
                                    "Выберите автомобиль",
                                    style: pickerStyle,
                                  ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
        _nextButton(context)
      ],
    );
  }

  Widget _nextButton(context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FullWidthElevButton(
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        title: "Далее",
        onPressed: () async {
          if (from != null ||
              to != null ||
              date != null ||
              time != null ||
              selectedCar != null) {
            final bool success = await pushNewScreen(
              context,
              withNavBar: false,
              screen: CreateRideDriverInfo(
                from: from!,
                to: to!,
                stopsList: stopsList,
                startTime: DateTime(
                  date!.year,
                  date!.month,
                  date!.day,
                  time!.hour,
                  time!.minute,
                ),
                car: selectedCar!,
              ),
            );
            if (success) {
              cleanData();
            }
          } else {
            InfoDialog().show(
                customIcon: const Icon(
                  CupertinoIcons.info_circle,
                  size: 90,
                  color: kPrimaryColor,
                ),
                title: "Что то не так:",
                children: [
                  const ListTile(
                    title: Text("Необходимо указать:"),
                  ),
                  _infoChecker(title: "Откуда поедете", object: from),
                  _infoChecker(title: "Куда держите путь", object: to),
                  _infoChecker(
                    title: "Дата поездки",
                    object: date,
                  ),
                  _infoChecker(
                    title: "Время выезда",
                    object: time,
                  ),
                  _infoChecker(
                    title: "Автомобиль",
                    object: selectedCar,
                  ),
                ]);
          }
        },
      ),
    );
  }

  Widget _infoChecker({
    Object? object,
    required String title,
  }) {
    return object == null
        ? ListTile(
            minLeadingWidth: 10,
            dense: true,
            leading: const Icon(Icons.chevron_right),
            title: Text(title),
          )
        : const SizedBox();
  }

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
        helpText: "Выберите дату поездки",
        cancelText: "Отмена",
        confirmText: "Ок",
        locale: const Locale("ru", "RU"),
        context: context,
        initialDate: date ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != date) {
      setState(() {
        date = picked;

        // "${picked.day}.${picked.month}.${picked.year.toString().substring(2)}";
      });
    }
  }

  void _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
        helpText: "Укажите время поездки",
        cancelText: "Отмена",
        confirmText: "Ок",
        hourLabelText: "Часы",
        minuteLabelText: "Минуты",
        context: context,
        initialTime: time ?? TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input,
        builder: (context, widget) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 24-Hour format
                  alwaysUse24HourFormat: true),
              // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
              child: widget!);
        });
    if (picked != null) {
      setState(() {
        time = picked;

        // "${picked.day}.${picked.month}.${picked.year.toString().substring(2)}";
      });
    }
  }

  void pickDestinition(TextEditingController? contoller, bool isFrom,
      String title, int? index) async {
    final Departure? destinition = await btmSheet.wait(context,
        useRootNavigator: true,
        child: PickCity(
          title: title,
        ));
    if (destinition != null) {
      if (contoller != null) {
        setState(() {
          contoller.text = destinition.name!;
          isFrom ? from = destinition : to = destinition;
        });
      } else {
        setState(() {
          _midwayControllers[index!].text = destinition.name!;
          stopsList.add(destinition);
          isFrom ? from = destinition : to = destinition;
        });
      }
    }
  }

  void pickCar(
    context,
  ) async {
    final Car? car = await btmSheet.wait(context,
        useRootNavigator: true, child: const PickCar());
    if (car != null) {
      setState(() {
        selectedCar = car;
      });
    }
  }

  void cleanData() async {
    from = null;
    to = null;
    date = null;
    time = null;
    selectedCar = null;
    startWay.clear();
    midWays.clear();
    _midwayControllers = [];
    setState(() {});
    endWay.clear();
    _midwayControllers.clear();
  }
}
