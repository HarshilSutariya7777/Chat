import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Pages/HomePage/widget/ChatTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        InkWell(
          onTap: () {
            Get.toNamed("/chatPage");
          },
          child: ChatTile(
            imageUrl: Assetimage.defultprofileImage,
            name: "Harshil Sutariya",
            lastChat: "Keshe Ho Bhai",
            lastTime: "08:33 PM",
          ),
        ),
        InkWell(
          onTap: () {
            Get.toNamed("/chatPage");
          },
          child: ChatTile(
            imageUrl: Assetimage.defultprofileImage,
            name: "Harshil Sutariya",
            lastChat: "Keshe Ho Bhai",
            lastTime: "08:33 PM",
          ),
        ),
      ],
    );
  }
}
