import 'package:chatapp3/Config/PagePath.dart';
import 'package:chatapp3/Config/Theme.dart';
import 'package:chatapp3/Pages/SpleshScreen/SpleshScreen.dart';
import 'package:chatapp3/Pages/Welcome/Welcomepage.dart';
import 'package:chatapp3/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      getPages: pagePath,
      themeMode: ThemeMode.dark,
      home: const SpleshScreenPage(),
    );
  }
}
