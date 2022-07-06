import 'package:app_poezdka/database/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserCarsList extends StatelessWidget {
  final List<CarData> cars;
  const UserCarsList({Key? key, required this.cars}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, int index) {
          final car = cars[index];

          return Text(car.mark!);
        });
  }
}

class MyCarList2 extends StatelessWidget {
  final int userId;
  const MyCarList2({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carsDB = Provider.of<MyDatabase>(context).carDao;
    return FutureBuilder<List<CarData>>(
        future: carsDB.getUserCars(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final cars = snapshot.data ?? [];
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cars.length,
                itemBuilder: (context, int index) => ListTile(
                      title: Text(
                        "${cars[index].mark}",
                      ),
                      trailing: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Удалить",
                            style: TextStyle(color: Colors.red),
                          )),
                    ));
          }
          return const CircularProgressIndicator();
        });
  }
}
