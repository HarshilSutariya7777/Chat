import 'package:chatapp3/Controller/AuthController.dart';
import 'package:chatapp3/Widget/PrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Column(
      children: [
        const SizedBox(height: 40),
        TextField(
          controller: name,
          decoration: const InputDecoration(
              hintText: "Full Name",
              prefixIcon: Icon(
                Icons.person,
              )),
        ),
        const SizedBox(height: 30),
        TextField(
          controller: email,
          decoration: const InputDecoration(
              hintText: "Email",
              prefixIcon: Icon(
                Icons.alternate_email_rounded,
              )),
        ),
        const SizedBox(height: 30),
        TextField(
          controller: password,
          decoration: const InputDecoration(
              hintText: "Password",
              prefixIcon: Icon(
                Icons.password_outlined,
              )),
        ),
        const SizedBox(height: 60),
        Obx(
          () => authController.isLoading.value
              ? const CircularProgressIndicator()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryButton(
                        btnName: "SIGNUP",
                        icon: Icons.lock_open_outlined,
                        ontap: () {
                          authController.createUser(
                              email.text, password.text, name.text);
                        }),
                  ],
                ),
        ),
      ],
    );
  }
}
