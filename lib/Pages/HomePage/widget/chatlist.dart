import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Controller/ContactController.dart';
import 'package:chatapp3/Controller/ProfileController.dart';
import 'package:chatapp3/Pages/Chat/ChatPage.dart';
import 'package:chatapp3/Pages/HomePage/widget/ChatTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    ProfileController profileController = Get.put(ProfileController());
    return RefreshIndicator(
        child: Obx(
          () => ListView(
            children: contactController.chatRoomList
                .map(
                  (e) => InkWell(
                    onTap: () {
                      Get.to(ChatPage(
                          userModel: (e.receiver!.id ==
                                  profileController.currentUser.value.id
                              ? e.sender
                              : e.receiver)!));
                    },
                    child: ChatTile(
                      imageUrl: (e.receiver!.id ==
                                  profileController.currentUser.value.id
                              ? e.sender!.profileImage
                              : e.receiver!.profileImage) ??
                          Assetimage.defultprofileImage,
                      name: (e.receiver!.id ==
                              profileController.currentUser.value.id
                          ? e.sender!.name
                          : e.receiver!.name)!,
                      lastChat: e.lastMessage ?? "Last Message",
                      lastTime: e.lastMessageTimestamp ?? "Last Time",
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        onRefresh: () {
          return contactController.getChatRoomList();
        });
  }
}
