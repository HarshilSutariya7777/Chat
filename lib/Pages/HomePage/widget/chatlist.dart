import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Controller/ContactController.dart';
import 'package:chatapp3/Pages/Chat/ChatPage.dart';
import 'package:chatapp3/Pages/HomePage/widget/ChatTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    return RefreshIndicator(
        child: Obx(
          () => ListView(
            children: contactController.chatRoomList
                .map(
                  (e) => InkWell(
                    onTap: () {
                      Get.to(ChatPage(userModel: e.receiver!));
                    },
                    child: ChatTile(
                      imageUrl: e.receiver!.profileImage ??
                          Assetimage.defultprofileImage,
                      name: e.receiver!.name ?? "User Name",
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
