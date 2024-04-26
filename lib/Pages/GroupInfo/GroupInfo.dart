import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Model/GroupModel.dart';
import 'package:chatapp3/Pages/GroupInfo/GroupMemberInfo.dart';
import 'package:chatapp3/Pages/HomePage/widget/ChatTile.dart';
import 'package:chatapp3/Pages/UserProfile/Widget/ProfileUserInfo.dart';
import 'package:flutter/material.dart';

class GroupInfo extends StatelessWidget {
  final GroupModel groupModel;
  const GroupInfo({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(groupModel.name!),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            GroupMemberInfo(
              profileImage: groupModel.profileUrl == ""
                  ? Assetimage.defultprofileImage
                  : groupModel.profileUrl!,
              userName: groupModel.name!,
              userEmail: groupModel.description ?? "No Description Available",
              groupId: groupModel.id!,
            ),
            SizedBox(height: 20),
            Text(
              "Members",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: 10),
            Column(
              children: groupModel.members!
                  .map(
                    (member) => ChatTile(
                      imageUrl:
                          member.profileImage ?? Assetimage.defultprofileImage,
                      name: member.name!,
                      lastChat: member.email!,
                      lastTime: member.role == "admin" ? "Admin" : "User",
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
