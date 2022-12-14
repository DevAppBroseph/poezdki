import 'dart:async';
import 'package:app_poezdka/bloc/chat/chat_bloc.dart';
import 'package:app_poezdka/bloc/profile/profile_bloc.dart';
import 'package:app_poezdka/bloc/trips_driver/trips_bloc.dart';
import 'package:app_poezdka/bloc/trips_passenger/trips_passenger_bloc.dart';
import 'package:app_poezdka/bloc/user_trips_driver/user_trips_driver_bloc.dart';
import 'package:app_poezdka/bloc/user_trips_passenger/user_trips_passenger_bloc.dart';
import 'package:app_poezdka/const/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
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

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  final appDocumentDirectory = await getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);
  await Hive.openBox(HiveBox.appBox.box);

  runApp(App());
}

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String? referalLink;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    handleDynamicLinks();
  }

  Future handleDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (data != null) {
      final ref = data.link.toString().split('/');
      referalLink = ref.last;
      // Future.delayed(const Duration(seconds: 1), () {
      // BlocProvider.of<ProfileBloc>(context).add(SetReferal(referalLink));
      // SmartDialog.show(
      //   builder: (context) {
      //     return Text(referalLink!);
      //   },
      // );
      // });
      // setState(() {
      //   loading = false;
      // });
    }
    // else {
    //   setState(() {
    //     loading = false;
    //   });
    // }
    setState(() {
      loading = false;
    });
  }

  // https://referalpoezdki.page.link/referal?ref=testMYreferalLINK123
  // https://apppoezdka.page.link/n3UL?link=https%3A%2F%2Fapppoezdka.page.link%2F

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
          create: (context) {
            // BlocProvider.of<ProfileBloc>(context).add(SetReferal(referalLink));
            return ProfileBloc(userRepository)
              ..add(LoadProfile())
              ..add(SetReferal(referalLink));
          },
        ),
        BlocProvider<AuthBloc>(
          create: (context) {
            return AuthBloc(
              userRepository: userRepository,
              appRepository: appRepository,
            )..add(AppStarted());
            // ..add(CheckReferal());
          },
        ),
        BlocProvider<ChatBloc>(
          create: (context) {
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
        home: loading == false
            ? AppInitBuilder(referal: referalLink)
            : const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }
}
