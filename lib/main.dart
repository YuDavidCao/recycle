import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:recycle/controller/classification_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recycle/route.dart';
import 'pages.dart';

late Box settingBox;
late Box dailyProgressBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.init((await getApplicationDocumentsDirectory()).path);
  settingBox = await Hive.openBox('setting');
  dailyProgressBox = await Hive.openBox('dailyProgress');
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ClassificationState()..loadModel()),
      ],
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'App',
          theme: ThemeData(
            primarySwatch: const MaterialColor(0xFF50C878, {
              50: Color(0xFF50C878),
              100: Color(0xFF50C878),
              200: Color(0xFF50C878),
              300: Color(0xFF50C878),
              400: Color(0xFF50C878),
              500: Color(0xFF50C878),
              600: Color(0xFF50C878),
              700: Color(0xFF50C878),
              800: Color(0xFF50C878),
              900: Color(0xFF50C878),
            }),
          ),
          home: const HomePage(),
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }
}
