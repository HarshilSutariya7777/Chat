import 'package:chatapp3/Pages/Welcome/Widget/WelcomeBody.dart';
import 'package:chatapp3/Pages/Welcome/Widget/WelcomeButton.dart';
import 'package:chatapp3/Pages/Welcome/Widget/WelcomeHeading.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            WelcomeHeading(),
            WelcomeBody(),
            WelcomeButton(),
          ],
        ),
      )),
    );
  }
}
