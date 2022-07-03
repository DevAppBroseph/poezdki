import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/src/rides/components/waypoints.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RideMainInfo extends StatelessWidget {
  final TextEditingController startWay;
  final TextEditingController endWay;
  final List<TextEditingController> midWays;
  final List<TextEditingController> midwayControllers;
  final Function onAdd;
  final Function onDelete;
  final Function onPickDate;
  final Function onPickTime;

  final int? midWayIndex;
  final DateTime? date;
  final TimeOfDay? time;
  const RideMainInfo(
      {Key? key,
      required this.startWay,
      required this.endWay,
      required this.midWays,
      required this.midwayControllers,
      required this.onAdd,
      required this.onDelete,
      this.midWayIndex,
      required this.onPickDate,
      required this.onPickTime,
      this.date,
      this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle pickerStyle =
        TextStyle(color: Colors.grey, fontWeight: FontWeight.w300);
    const TextStyle carStyle =
        TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w300);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WayPoints(
              startWay: startWay,
              endWay: endWay,
              midWays: midWays,
              midwayControllers: midwayControllers,
              onAdd: onAdd as void Function(),
              onDelete: onDelete as void Function(),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text("Дата"),
                      trailing: TextButton(
                          onPressed: onPickDate as void Function(),
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
                          onPressed: onPickTime as void Function(),
                          child: Text(
                            time != null
                                ? "${time!.hour.toString().padLeft(2, '0')}:${time!.minute.toString().padLeft(2, '0')}"
                                : "Укажите время",
                            style: pickerStyle,
                          )),
                    ),
                    const ListTile(
                      title: Text("Автомобиль"),
                      trailing: Text(
                        "BMW 3 Синий",
                        style: carStyle,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
