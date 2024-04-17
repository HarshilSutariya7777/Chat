import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Pages/HomePage/widget/ChatTile.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ChatTile(
          imageUrl: Assetimage.girlPic,
          name: "Harshil Sutariya",
          lastChat: "Keshe Ho Bhai",
          lastTime: "08:33 PM",
        ),
      ],
    );
  }
}
