import 'package:app_poezdka/database/database.dart';
import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/widget/dialog/error_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

class AuthDB {
  Future signUp(BuildContext context,
      {required String login,
      required String password,
      required String firstName,
      required String lastName,
      required String gender,
      required int birth}) async {
    var uuid = const Uuid();
    final db = Provider.of<MyDatabase>(context, listen: false).userDao;
    // final blocAuth = BlocProvider.of<AuthBloc>(context, listen: false);
    final token = uuid.v4();
    try {
      db
          .signUp(UserData(
              id: null,
              login: login,
              password: password,
              token: token,
              name: firstName,
              surname: lastName,
              gender: gender,
              dob: birth))
          .onError((error, stackTrace) {
        throw (e) => (e.toString());
      });

      // blocAuth.add(LoggedIn(login, token));
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      ErrorDialogs().showError(e.toString());
    }
  }

  Future signIn(
    context, {
    required String login,
    required String password,
  }) async {
    final db = Provider.of<MyDatabase>(context, listen: false).userDao;
    // final blocAuth = BlocProvider.of<AuthBloc>(context);
    try {
      final user = await db.getUserLogin(login: login, password: password);
      if (login == user!.login && password == user.password) {
        // blocAuth.add(LoggedIn(user.login!, user.token!));
      }
    } catch (e) {
      ErrorDialogs().showError(e.toString());
    }
  }

  Future logOut(
    context,
  ) async {
    final blocAuth = BlocProvider.of<AuthBloc>(context);
    try {
      blocAuth.add(LoggedOut());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
