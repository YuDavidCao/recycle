import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:recycle/constants.dart';
import 'package:recycle/controller/classification_helper_state.dart';
import 'package:recycle/controller/classification_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recycle/controller/daily_progress_state.dart';
import 'package:recycle/firebase_options.dart';
import 'package:recycle/model/daily_progress_model.dart';
import 'package:recycle/route.dart';
import 'pages.dart';

late Box settingBox;
late Box dailyProgressBox;
late Box totalStatisticBox;

//TODO reset statistic needs to be done quick --- for testing and developing purpose

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Hive.init((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(DailyProgressModelAdapter());
  settingBox = await Hive.openBox('setting');
  dailyProgressBox = await Hive.openBox('dailyProgress');
  totalStatisticBox = await Hive.openBox("totalStatisticBox");
  settingBox.put("image tracking agreement", false);
  settingBox.put("image classification description", false);
  if (!settingBox.containsKey("first time initialization")) {
    settingBox.put("first time initialization", true);
    settingBox.put("image tracking agreement", false);
    settingBox.put("image classification description", false);
    settingBox.put("prevDate", null);
    for (int i = 0; i < classificationLabels.length; i++) {
      totalStatisticBox.put("${classificationLabels[i]}Count", 0);
    }
    totalStatisticBox.put("totalCount", 0);
  }
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
        ChangeNotifierProvider(
            create: (_) => DailyProgressState()..calcDailyProgress()),
        ChangeNotifierProvider(create: (_) => ClassificationHelperState()),
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
