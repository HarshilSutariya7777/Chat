import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Controller/GroupController.dart';
import 'package:chatapp3/Pages/GroupChat/GroupChat.dart';
import 'package:chatapp3/Pages/HomePage/widget/ChatTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    return Obx(
      () => ListView(
        children: groupController.groupList
            .map(
              (group) => InkWell(
                onTap: () {
                  Get.to(GroupChatPage(groupModel: group));
                },
                child: ChatTile(
                  imageUrl: group.profileUrl == ""
                      ? Assetimage.defultprofileImage
                      : group.profileUrl!,
                  name: group.name!,
                  lastChat: "Group Created",
                  lastTime: group.timeStamp!,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
