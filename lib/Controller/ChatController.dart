import 'package:chatapp3/Controller/ContactController.dart';
import 'package:chatapp3/Controller/ProfileController.dart';
import 'package:chatapp3/Model/AudioCall.dart';
import 'package:chatapp3/Model/ChatModel.dart';
import 'package:chatapp3/Model/ChatRoomModel.dart';
import 'package:chatapp3/Model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  var uuid = const Uuid();
  ProfileController profileController = Get.put(ProfileController());
  //image show
  RxString selectedImagePath = "".obs;
  //video show
  RxString selectedVideoPath = "".obs;
  //save contact
  ContactController contactController = Get.put(ContactController());

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

  //get sender user
  UserModel getSender(UserModel currentUser, UserModel targetUser) {
    String currentUserId = currentUser.id!;
    String targetUserId = targetUser.id!;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return currentUser;
    } else {
      return targetUser;
    }
  }

  //get recevier user
  UserModel getReceiver(UserModel currentUser, UserModel targetUser) {
    String currentUserId = currentUser.id!;
    String targetUserId = targetUser.id!;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return targetUser;
    } else {
      return currentUser;
    }
  }

  //send message code
  //create chat collection
  //uuid create uniq user id to chat user
  Future<void> sendMessage(
      String targetUserId, String message, UserModel targetUser) async {
    isLoading.value = true;
    String chatid = uuid.v6();
    String roomID = getRoomId(targetUserId);
    DateTime timestamp = DateTime.now();
    String nowTime = DateFormat("hh:mm a").format(timestamp);

    UserModel sender =
        getSender(profileController.currentUser.value, targetUser);
    UserModel receiver =
        getReceiver(profileController.currentUser.value, targetUser);

    RxString imageUrl = "".obs;
    if (selectedImagePath.value.isNotEmpty) {
      imageUrl.value =
          await profileController.uploadFileToFirebase(selectedImagePath.value);
    }
    RxString videoUrl = "".obs;
    if (selectedVideoPath.value.isNotEmpty) {
      videoUrl.value = await profileController
          .uploadVideoToFirebase(selectedVideoPath.value);
    }
    print("video url:$videoUrl");
    var newChat = ChatModel(
      id: chatid,
      message: message,
      imageUrl: imageUrl.value,
      videoUrl: videoUrl.value,
      senderId: auth.currentUser!.uid,
      receiverId: targetUserId,
      senderName: profileController.currentUser.value.name,
      timestamp: DateTime.now().toString(),
    );

    var roomDetails = ChatRoomModel(
      id: roomID,
      lastMessage: message,
      lastMessageTimestamp: nowTime,
      sender: sender,
      receiver: receiver,
      timestamp: DateTime.now().toString(),
      unReadMessNo: 0,
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
      selectedImagePath.value = "";
      selectedVideoPath.value = "";
      await db.collection("chats").doc(roomID).set(
            roomDetails.toJson(),
          );
      await contactController.saveContct(targetUser);
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

//get Status
  Stream<UserModel> getStatus(String uid) {
    return db.collection("users").doc(uid).snapshots().map((event) {
      return UserModel.fromJson(event.data()!);
    });
  }

  //Getcalles List
  Stream<List<CallModel>> getCalls() {
    return db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("calls")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (e) => CallModel.fromJson(e.data()),
              )
              .toList(),
        );
  }
}
