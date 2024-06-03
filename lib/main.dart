import 'package:edu_app/core/res/colours.dart';
import 'package:edu_app/core/res/fonts.dart';
import 'package:edu_app/core/services/injection_container.dart';
import 'package:edu_app/core/services/router.dart';
import 'package:edu_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: Fonts.poppins,
        appBarTheme: const AppBarTheme(color: Colors.transparent),
        colorScheme: ColorScheme.fromSwatch(accentColor: Colours.primaryColour),
      ),
      onGenerateRoute: generateRoute,
    );
  }
}
