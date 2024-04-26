import 'package:chatapp3/Model/AudioCall.dart';
import 'package:chatapp3/Model/UserModel.dart';
import 'package:chatapp3/Pages/CallPage/AudioCallPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CallController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final uuid = Uuid().v4();

  void onInit() {
    super.onInit();

    getCallNotification().listen((List<CallModel> callList) {
      if (callList.isNotEmpty) {
        var callData = callList[0];
        Get.snackbar(callData.callerName!, "Incoming Call",
            duration: Duration(days: 1),
            barBlur: 0,
            isDismissible: false,
            backgroundColor: Colors.grey[900]!,
            icon: Icon(Icons.call), onTap: (snack) {
          Get.back();
          Get.to(
            AudioCallPage(
              target: UserModel(
                id: callData.callerUid,
                name: callData.callerName,
                email: callData.callerEmail,
                profileImage: callData.callerPic,
              ),
            ),
          );
        },
            mainButton: TextButton(
              onPressed: () {
                endCall(callData);
                Get.back();
              },
              child: Text("End Call"),
            ));
      }
    });
  }

//create call click action when user call to recevier.
  Future<void> callAction(UserModel reciver, UserModel caller) async {
    String id = uuid;
    var newCall = CallModel(
      id: id,
      callerName: caller.name,
      callerPic: caller.profileImage,
      callerUid: caller.id,
      callerEmail: caller.email,
      receiverEmail: reciver.email,
      receiverName: reciver.name,
      receiverPic: reciver.profileImage,
      receiverUid: reciver.id,
      status: "Dialing",
      type: "audio",
    );
    try {
      await db
          .collection("notification")
          .doc(reciver.id)
          .collection("call")
          .doc(id)
          .set(
            newCall.toJson(),
          );

      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("calls")
          .doc(id)
          .set(newCall.toJson());
      await db
          .collection("users")
          .doc(reciver.id)
          .collection("calls")
          .doc(id)
          .set(newCall.toJson());
      Future.delayed(Duration(seconds: 20), () {
        endCall(newCall);
      });
    } catch (e) {
      print(e);
    }
  }

  //get Notification
  Stream<List<CallModel>> getCallNotification() {
    return FirebaseFirestore.instance
        .collection("notification")
        .doc(auth.currentUser!.uid)
        .collection("call")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CallModel.fromJson(doc.data()))
            .toList());
  }

  //when call end that time delete call
  Future<void> endCall(CallModel call) async {
    try {
      await db
          .collection("notification")
          .doc(call.receiverUid)
          .collection("call")
          .doc(call.id)
          .delete();
    } catch (e) {
      print(e);
    }
  }
}
