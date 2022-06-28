import 'package:app_poezdka/const/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

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
  final userRepository = SecureStorage.instance;
  final appRepository = HiveBoxService.instance;
  runApp(
    BlocProvider<AuthBloc>(
        create: (context) {
          return AuthBloc(
              userRepository: userRepository, appRepository: appRepository)
            ..add(AppStarted());
        },
        child: const App()),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Poezdka',
      theme: appTheme,
      builder: FlutterSmartDialog.init(),
      // home: MultiBlocProvider(providers: [], child: const AppInitBuilder()),
      home: const AppInitBuilder(),
    );
  }
}
