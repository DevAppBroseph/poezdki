import 'package:drift/drift.dart';

import '../database.dart';

part 'cars.g.dart';

class Car extends Table {
  IntColumn? get id => integer().autoIncrement()();
  IntColumn? get ownerId => integer().nullable()();
  TextColumn? get mark => text().nullable()();
}

@DriftAccessor(tables: [Car])
class CarDao extends DatabaseAccessor<MyDatabase> with _$CarDaoMixin {
  CarDao(MyDatabase db) : super(db);
  Future<List<CarData>> getUserCars(int owner) {
    return ((select(car)..where((f) => f.ownerId.equals(owner)))).get();
  }
  // Stream<UserSetting> streamSettings() {
  //   return ((select(userSettings)
  //     ..where((f) =>
  //         f.id.equals(1))))
  //       .watchSingle();
  // }

  Future createSettings(Insertable<CarData> carData) =>
      into(car).insert(carData);
  Future updateSettings(Insertable<CarData> carData) =>
      update(car).replace(carData);
}
