import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Controller/AuthController.dart';
import 'package:chatapp3/Controller/ProfileController.dart';
import 'package:chatapp3/Model/UserModel.dart';
import 'package:chatapp3/Pages/UserProfile/Widget/ProfileUserInfo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UserProfilePage extends StatelessWidget {
  final UserModel userModel;
  const UserProfilePage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed("/updateprofile");
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            LoginUserInfo(
                profileImage:
                    userModel.profileImage ?? Assetimage.defultprofileImage,
                userEmail: userModel.email ?? "",
                userName: userModel.name ?? "User"),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                authController.logoutUser();
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
