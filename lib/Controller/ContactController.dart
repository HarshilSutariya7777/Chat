import 'package:chatapp3/Model/ChatRoomModel.dart';
import 'package:chatapp3/Model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  RxList<UserModel> userList = <UserModel>[].obs;
  RxList<ChatRoomModel> chatRoomList = <ChatRoomModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getUserList();
    await getChatRoomList();
  }

//code for get all user list in contact page //data get into firebase
  Future<void> getUserList() async {
    isLoading.value = true;
    try {
      userList.clear();
      await db.collection("users").get().then((value) => {
            userList.value = value.docs
                .map(
                  (e) => UserModel.fromJson(
                    e.data(),
                  ),
                )
                .toList(),
          });
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

  //fetch chated user into home page
  Future<void> getChatRoomList() async {
    List<ChatRoomModel> tempChatRoom = [];
    await db
        .collection('chats')
        .orderBy("timestamp", descending: true)
        .get()
        .then(
          (value) => tempChatRoom =
              value.docs.map((e) => ChatRoomModel.fromJson(e.data())).toList(),
        );
    //
    chatRoomList.value = tempChatRoom
        .where((e) => e.id!.contains(auth.currentUser!.uid))
        .toList();
  }

//save contact
  Future<void> saveContct(UserModel user) async {
    try {
      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("contacts")
          .doc(user.id)
          .set(user.toJson());
    } catch (e) {
      if (kDebugMode) {
        print("error to saving contact" + e.toString());
      }
    }
  }

//get all my contacts
  Stream<List<UserModel>> getContacts() {
    return db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("contacts")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => UserModel.fromJson(
                doc.data(),
              ),
            )
            .toList());
  }
}
