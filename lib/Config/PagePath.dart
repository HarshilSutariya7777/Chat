import 'package:chatapp3/Pages/Auth/Auth.dart';
import 'package:chatapp3/Pages/Chat/ChatPage.dart';
import 'package:chatapp3/Pages/HomePage/HomePage.dart';
import 'package:chatapp3/Pages/Profile/ProfilePage.dart';
import 'package:chatapp3/Pages/Profile/UpdateProfile.dart';
import 'package:get/get.dart';

var pagePath = [
  GetPage(
    name: "/authPage",
    page: () => AuthPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: "/homePage",
    page: () => HomePage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: "/chatPage",
    page: () => ChatPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: "/profilePage",
    page: () => ProfilePage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: "/updateprofile",
    page: () => UpdateProfile(),
    transition: Transition.rightToLeft,
  ),
];
