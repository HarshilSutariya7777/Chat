import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Pages/HomePage/widget/ChatTile.dart';
import 'package:flutter/material.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ChatTile(
            imageUrl: Assetimage.defultprofileImage,
            name: "Study Group",
            lastChat: "Last Message",
            lastTime: "lastTime")
      ],
    );
  }
}
