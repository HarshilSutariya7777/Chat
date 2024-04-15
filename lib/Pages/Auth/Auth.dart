import 'package:chatapp3/Pages/Auth/AuthpageBody.dart';
import 'package:chatapp3/Pages/Welcome/Widget/WelcomeHeading.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(children: [
              WelcomeHeading(),
              SizedBox(height: 40),
              AuthPageBody(),
            ]),
          ),
        ),
      ),
    );
  }
}
