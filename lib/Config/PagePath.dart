import 'package:chatapp3/Pages/Auth/Auth.dart';
import 'package:chatapp3/Pages/ContactPage/ContactPage.dart';
import 'package:chatapp3/Pages/HomePage/HomePage.dart';
import 'package:get/get.dart';

var pagePath = [
  GetPage(
    name: "/authPage",
    page: () => const AuthPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: "/homePage",
    page: () => const HomePage(),
    transition: Transition.rightToLeft,
  ),
  // GetPage(
  //   name: "/chatPage",
  //   page: () => ChatPage(),
  //   transition: Transition.rightToLeft,
  // ),
  GetPage(
    name: "/contactPage",
    page: () => const ContactPage(),
    transition: Transition.rightToLeft,
  ),
  // GetPage(
  //   name: "/profilePage",
  //   page: () => UserProfilePage(),
  //   transition: Transition.rightToLeft,
  // ),
  // GetPage(
  //   name: "/updateprofile",
  //   page: () => UserUpdateProfile(),
  //   transition: Transition.rightToLeft,
  // ),
];
