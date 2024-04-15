import 'package:chatapp3/Config/PagePath.dart';
import 'package:chatapp3/Config/Theme.dart';
import 'package:chatapp3/Pages/SpleshScreen/SpleshScreen.dart';
import 'package:chatapp3/Pages/Welcome/Welcomepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
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
      home: const WelcomePage(),
    );
  }
}
