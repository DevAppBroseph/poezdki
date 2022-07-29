import 'package:drift/drift.dart';

import '../database.dart';

part 'ride.g.dart';

class Ride extends Table {
  IntColumn? get id => integer().autoIncrement().nullable()();
  IntColumn? get owner => integer().nullable()();
  TextColumn? get ownerName => text().nullable()();
  TextColumn? get type => text().nullable()();
  TextColumn? get from => text().nullable()();
  TextColumn? get waypoint => text().nullable()();
  TextColumn? get to => text().nullable()();
  DateTimeColumn? get date => dateTime().nullable()();
  DateTimeColumn? get time => dateTime().nullable()();
  TextColumn? get car => text().nullable()();
  //Info
  BoolColumn? get isPackageTransfer => boolean().nullable()();
  BoolColumn? get isTwoBackSeat => boolean().nullable()();
  BoolColumn? get isBagadgeTransfer => boolean().nullable()();
  BoolColumn? get isChildSeat => boolean().nullable()();
  BoolColumn? get isCondition => boolean().nullable()();
  BoolColumn? get isSmoking => boolean().nullable()();
  BoolColumn? get isPetTransfer => boolean().nullable()();
  BoolColumn? get isPickUpFromHome => boolean().nullable()();
  RealColumn? get price => real().nullable()();
  //Passangers
  IntColumn? get passanger1 => integer().nullable()();
  IntColumn? get passanger2 => integer().nullable()();
  IntColumn? get passanger3 => integer().nullable()();
  IntColumn? get passanger4 => integer().nullable()();
}

@DriftAccessor(tables: [Ride])
class RideDao extends DatabaseAccessor<MyDatabase> with _$RideDaoMixin {
  RideDao(MyDatabase db) : super(db);
  // Future<UserSetting> userSettingsAsFuture () {
  //   return ((select(userSettings)
  //     ..where((f) =>
  //         f.id.equals(1))))
  //       .getSingle();
  // }
  // Stream<UserSetting> streamSettings() {
  //   return ((select(userSettings)
  //     ..where((f) =>
  //         f.id.equals(1))))
  //       .watchSingle();
  // }

  Future<List<RideData>> getAllRidesAsFututre() {
    return ((select(ride))).get();
  }

  Stream<List<RideData>> getAllRidesAsStream() {
    return ((select(ride))).watch();
  }

  Stream<List<RideData>> getFilteredRides(
      {required String from,
      required String to,
      required bool? isPackageTransfer}) {
    return ((select(ride))
          ..where((tbl) {
            return from.isNotEmpty && to.isNotEmpty
                ? tbl.from.contains(from) & tbl.to.contains(to)
                : from.isNotEmpty && to.isEmpty
                    ? tbl.from.contains(from)
                    : tbl.to.contains(to);
          })
          ..where((tbl) => tbl.isPackageTransfer.equals(isPackageTransfer)))
        .watch();
  }

  Stream<List<RideData>> streamMyUpcominRides(int ownerId) {
    final today = DateTime.now();
    return ((select(ride)
          ..where((tbl) => tbl.owner.equals(ownerId))
          ..where((tbl) => tbl.date.isBiggerThanValue(today))))
        .watch();
  }

  Stream<List<RideData>> streamMyPastRides(int ownerId) {
    final today = DateTime.now();
    return ((select(ride)
          ..where((tbl) => tbl.owner.equals(ownerId))
          ..where((tbl) => tbl.date.isSmallerThanValue(today))))
        .watch();
  }

  Future createRide(Insertable<RideData> rideData) =>
      into(ride).insert(rideData);
  Future updateRide(Insertable<RideData> rideData) =>
      update(ride).replace(rideData);
}
