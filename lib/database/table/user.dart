import 'package:app_poezdka/export/services.dart';
import 'package:drift/drift.dart';

import '../database.dart';

part 'user.g.dart';

class User extends Table {
  IntColumn? get id => integer().autoIncrement().nullable()();
  TextColumn? get login => text().nullable()();
  TextColumn? get password => text().nullable()();
  TextColumn? get token => text().nullable()();
  TextColumn? get name => text().nullable()();
  TextColumn? get surname => text().nullable()();
  TextColumn? get gender => text().nullable()();
  IntColumn? get dob => integer().nullable()();
}

@DriftAccessor(tables: [User])
class UserDao extends DatabaseAccessor<MyDatabase> with _$UserDaoMixin {
  UserDao(MyDatabase db) : super(db);
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

  Future signUp(Insertable<UserData> userData) => into(user).insert(userData);
  Future updateUserData(Insertable<UserData> userData) =>
      update(user).replace(userData);

  Future<UserData?> getUserLogin(
      {required String login, required String password}) async {
    var users = await ((select(user))).get();
    final UserData? userData = users.firstWhere(
        (UserData data) => login == data.login && password == data.password,
        orElse: () =>
            throw ("Ошибка авторизации. Проверьте правильность ввода E-mail и пароль"));
    return userData;
  }

  Future<UserData> getUserById( int id) async {
    return ((select(user)..where((f) => f.id.equals(id)))).getSingle();
  }

  Future<UserData?> getUserData() async {
    final userRepo = SecureStorage.instance;
    final token = await userRepo.getToken();
    if (token != null) {
      return ((select(user)..where((f) => f.token.equals(token)))).getSingle();
    } else {
      return null;
    }
  }
}
