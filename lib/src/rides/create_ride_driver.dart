import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/src/rides/components/waypoints.dart';
import 'package:app_poezdka/widget/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CreateRideDriver extends StatefulWidget {
  const CreateRideDriver({Key? key}) : super(key: key);

  @override
  State<CreateRideDriver> createState() => _CreateRideDriverState();
}

class _CreateRideDriverState extends State<CreateRideDriver> {
  final TextEditingController startWay = TextEditingController();
  final TextEditingController endWay = TextEditingController();
  final List<TextEditingController> _midwayControllers = [];
  var midWays = <TextEditingController>[];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WayPoints(
              startWay: startWay,
              endWay: endWay,
              midWays: midWays,
              midwayControllers: _midwayControllers,
              onAdd: () {
                setState(() {
                  midWays.add(TextEditingController());
                  _midwayControllers.add(TextEditingController());
                });
              }),
              _rideInfo(),
              const SizedBox(height: 80,)
        ],
      ),
    );
  }

  Widget _rideInfo() {
    const TextStyle pickerStyle =
        TextStyle(color: Colors.grey, fontWeight: FontWeight.w300);
         const TextStyle carStyle =
        TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w300);

    return Padding(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: const [
            ListTile(
              title: Text("Дата"),
              trailing: Text("Выберите дату",style: pickerStyle,),
            ),
            ListTile(
              title: Text("Время выезда"),
              trailing: Text("Укажите время", style: pickerStyle,),
            ),
            ListTile(
              title: Text("Автомобиль"),
               trailing: Text("BMW 3 Синий", style: carStyle,),
            ),
          ],
        ));
  }
}
