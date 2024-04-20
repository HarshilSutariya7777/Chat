import 'package:chatapp3/Controller/ProfileController.dart';
import 'package:chatapp3/Model/ChatModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  var uuid = Uuid();
  ProfileController profileController = Get.put(ProfileController());

//this code for get cureent user id and target user id
//user1+user2
//current+target second user
  String getRoomId(String targetUserId) {
    String currentUserId = auth.currentUser!.uid;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return currentUserId + targetUserId;
    } else {
      return targetUserId + currentUserId;
    }
  }

  //send message code
  //create chat collection
  //uuid create uniq user id to chat user
  Future<void> sendMessage(String targetUserId, String message) async {
    isLoading.value = true;
    String chatid = uuid.v6();
    String roomID = getRoomId(targetUserId);
    var newChat = ChatModel(
      id: chatid,
      message: message,
      senderId: auth.currentUser!.uid,
      receiverId: targetUserId,
      senderName: profileController.currentUser.value.name,
      timestamp: DateTime.now().toString(),
    );
    try {
      await db
          .collection("chats")
          .doc(roomID)
          .collection("messages")
          .doc(chatid)
          .set(
            newChat.toJson(),
          );
    } catch (e) {
      print(e);
    }

    isLoading.value = false;
  }

  //fetch all chat in messaging collection
  Stream<List<ChatModel>> getMessages(String targetUserId) {
    String roomID = getRoomId(targetUserId);
    return db
        .collection("chats")
        .doc(roomID)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatModel.fromJson(
                  doc.data(),
                ))
            .toList());
  }
}
