
import 'package:drift/drift.dart';

import '../database.dart';

part 'balance.g.dart';

class Balance extends Table {
  IntColumn? get id => integer().autoIncrement()();
  IntColumn? get ownerId => integer()();
  RealColumn? get balance => real().nullable()();
  RealColumn? get points => real().nullable()();



}

@DriftAccessor(tables: [Balance])

class BalanceDao extends DatabaseAccessor<MyDatabase> with _$BalanceDaoMixin{
  BalanceDao(MyDatabase db) : super(db);
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

  // Future createSettings(Insertable<UserSetting> userSetting) =>
  //     into(userSettings).insert(userSetting);
  // Future updateSettings(Insertable<UserSetting> userSetting) =>
  //     update(userSettings).replace(userSetting);
}