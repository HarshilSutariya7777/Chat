import 'package:chatapp3/Controller/ProfileController.dart';
import 'package:chatapp3/Model/ChatModel.dart';
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
  //get group
  RxList<GroupModel> groupList = <GroupModel>[].obs;
  ProfileController profileController = Get.put(ProfileController());
  final auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  RxString selectedImagePath = "".obs;

  @override
  void onInit() {
    super.onInit();
    getGroups();
  }

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
    groupMembers.add(
      UserModel(
        id: auth.currentUser!.uid,
        name: profileController.currentUser.value.name,
        profileImage: profileController.currentUser.value.profileImage,
        email: profileController.currentUser.value.email,
        role: "admin",
      ),
    );
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

//get groups
  Future<void> getGroups() async {
    isLoading.value = true;
    List<GroupModel> tempGroup = [];
    await db.collection('groups').get().then((value) {
      tempGroup = value.docs
          .map(
            (e) => GroupModel.fromJson(
              e.data(),
            ),
          )
          .toList();
    });
    groupList.clear();
    groupList.value = tempGroup
        .where(
          (e) =>
              e.members!.any((element) => element.id == auth.currentUser!.uid),
        )
        .toList();
    isLoading.value = false;
  }

//send Group Message
  Future<void> sendGroupMessage(
      String message, String groupId, String imagePath) async {
    isLoading.value = true;
    String chatid = uuid.v6();
    String imageUrl =
        await profileController.uploadFileToFirebase(selectedImagePath.value);
    var newChat = ChatModel(
      id: chatid,
      message: message,
      imageUrl: imageUrl,
      senderId: auth.currentUser!.uid,
      senderName: profileController.currentUser.value.name,
      timestamp: DateTime.now().toString(),
    );

    await db
        .collection("groups")
        .doc(groupId)
        .collection("messages")
        .doc(chatid)
        .set(newChat.toJson());
    selectedImagePath.value = "";
    isLoading.value = false;
  }

  //get group message
  Stream<List<ChatModel>> getGroupMessages(String groupId) {
    return db
        .collection("groups")
        .doc(groupId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ChatModel.fromJson(doc.data()))
              .toList(),
        );
  }

  //add member in group
  Future<void> addMemberToGroup(String groupId, UserModel user) async {
    isLoading.value = true;
    await db.collection("groups").doc(groupId).update({
      "members": FieldValue.arrayUnion([user.toJson()]),
    });
    getGroups();
    isLoading.value = false;
  }
}
