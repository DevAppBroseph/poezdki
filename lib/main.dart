import 'package:app_poezdka/bloc/chat/chat_bloc.dart';
import 'package:app_poezdka/bloc/profile/profile_bloc.dart';
import 'package:app_poezdka/bloc/trips_driver/trips_bloc.dart';
import 'package:app_poezdka/bloc/trips_passenger/trips_passenger_bloc.dart';
import 'package:app_poezdka/bloc/user_trips_driver/user_trips_driver_bloc.dart';
import 'package:app_poezdka/bloc/user_trips_passenger/user_trips_passenger_bloc.dart';
import 'package:app_poezdka/const/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc/auth/auth_builder.dart';
import 'export/blocs.dart';
import 'export/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('key is' + (await FirebaseMessaging.instance.getToken()).toString());

  // await Parse().initialize(keyApplicationId, keyParseServerUrl,
  //     clientKey: keyClientKey,
  //     autoSendSessionId: true,
  //     coreStore: await CoreStoreSembastImp.getInstance());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  final appDocumentDirectory = await getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);
  await Hive.openBox(HiveBox.appBox.box);

  runApp(const App());
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
          create: (context) => TripsBloc()..add(LoadAllTripsList()),
        ),
        BlocProvider<TripsPassengerBloc>(
          create: (context) =>
              TripsPassengerBloc()..add(LoadPassengerTripsList()),
        ),
        BlocProvider<UserTripsDriverBloc>(
          create: (context) => UserTripsDriverBloc()..add(LoadUserTripsList()),
        ),
        BlocProvider<UserTripsPassengerBloc>(
          create: (context) =>
              UserTripsPassengerBloc()..add(LoadUserPassengerTripsList()),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(userRepository)..add(LoadProfile()),
        ),
        BlocProvider<AuthBloc>(
          create: (context) {
            print('auth');
            return AuthBloc(
              userRepository: userRepository,
              appRepository: appRepository,
            )..add(AppStarted());
          },
        ),
        BlocProvider<ChatBloc>(
          create: (context) {
            print('chat');
            return ChatBloc()..add(StartSocket());
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
      ),
    );
  }
}
