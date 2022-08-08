
import 'package:app_poezdka/model/trip_model.dart';
import 'package:app_poezdka/service/server/car_service.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(CupertinoIcons.chevron_down)),
        title: const Text("Выберите автомобиль"),
      ),
      body: FutureBuilder<List<Car>>(
        future: CarService().getUserCars(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            final cars = snapshot.data ?? [];
            return  Padding(
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
              ],
            ),
          );
          }
          return const CircularProgressIndicator();
        }
      ),
    );
  }
}
