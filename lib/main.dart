import 'package:app_poezdka/bloc/my_rides/my_rides_bloc.dart';
import 'package:app_poezdka/bloc/profile/profile_bloc.dart';
import 'package:app_poezdka/bloc/trips/trips_bloc.dart';
import 'package:app_poezdka/const/theme.dart';
import 'package:app_poezdka/database/database.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'bloc/auth/auth_builder.dart';
import 'export/blocs.dart';
import 'export/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  final appDocumentDirectory = await getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);
  await Hive.openBox(HiveBox.appBox.box);

  runApp(
    Provider<MyDatabase>(
      create: (context) => MyDatabase(),
      dispose: (context, db) => db.close(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userRepository = SecureStorage.instance;
    final appRepository = HiveBoxService.instance;
    return MultiBlocProvider(
        providers: [
          BlocProvider<TripsBloc>(
            create: (context) => TripsBloc()..add(LoadTipsList()),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) =>
                ProfileBloc(userRepository)..add(LoadProfile()),
          ),
          BlocProvider<AuthBloc>(
            create: (context) {
              return AuthBloc(
                  userRepository: userRepository, appRepository: appRepository)
                ..add(AppStarted());
            },
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Poezdka',
          theme: appTheme,
          builder: FlutterSmartDialog.init(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ru')],
          // home: MultiBlocProvider(providers: [], child: const AppInitBuilder()),
          home: const AppInitBuilder(),
        ));
  }
}
