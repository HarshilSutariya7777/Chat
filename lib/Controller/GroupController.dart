import 'package:chatapp3/Controller/ProfileController.dart';
import 'package:chatapp3/Model/GroupModel.dart';
import 'package:chatapp3/Model/UserModel.dart';
import 'package:chatapp3/Pages/HomePage/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class GroupController extends GetxController {
  RxList<UserModel> groupMembers = <UserModel>[].obs;
  final db = FirebaseFirestore.instance;
  var uuid = Uuid();
  ProfileController profileController = Get.put(ProfileController());
  final auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

//select Group Member and add into list.
  void selectMember(UserModel user) {
    if (groupMembers.contains(user)) {
      groupMembers.remove(user);
    } else {
      groupMembers.add(user);
    }
  }

  Future<void> createGroup(String groupName, String imagePath) async {
    isLoading.value = true;
    String groupId = uuid.v6();

    try {
      String imageUrl = await profileController.uploadFileToFirebase(imagePath);

      await db.collection("groups").doc(groupId).set(
        {
          "id": groupId,
          "name": groupName,
          "profileUrl": imageUrl,
          "members": groupMembers.map((e) => e.toJson()).toList(),
          "createdAt": DateTime.now().toString(),
          "createdBy": auth.currentUser!.uid,
          "timeStamp": DateTime.now().toString(),
        },
      );
      //group created tost
      Get.snackbar("Group Created", "Group Created Successfully");
      Get.offAll(HomePage());
      isLoading.value = false;
    } catch (e) {
      print("Error" + e.toString());
    }
  }
}
