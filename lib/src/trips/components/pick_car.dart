import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/service/server/car_service.dart';
import 'package:app_poezdka/src/profile/cars_data/add_car.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class PickCar extends StatefulWidget {
  const PickCar({Key? key}) : super(key: key);

  @override
  State<PickCar> createState() => _PickCarState();
}

class _PickCarState extends State<PickCar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(CupertinoIcons.chevron_down),
        ),
        title: const Text(
          "Выберите автомобиль",
        ),
      ),
      body: FutureBuilder<List<Car>>(
        future: CarService().getUserCars(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final cars = snapshot.data ?? [];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    shrinkWrap: true,
                    itemCount: cars.length,
                    itemBuilder: (context, int index) {
                      final car = cars[index];

                      return ListTile(
                        onTap: () => Navigator.pop(context, car),
                        title: Text("${car.mark} ${car.model}"),
                        subtitle: Text(car.color!),
                        // trailing: Text(car.vehicleNumber!),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: TextButton(
                      onPressed: () => pushNewScreen(
                        context,
                        screen: const AddCarWidget(),
                      ).then((value) {
                        setState(() {});
                      }),
                      child: const Text(
                        "Добавить автомобиль",
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
