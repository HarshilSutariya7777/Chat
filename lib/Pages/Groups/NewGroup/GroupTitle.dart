import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Controller/GroupController.dart';
import 'package:chatapp3/Pages/HomePage/widget/ChatTile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupTitle extends StatelessWidget {
  const GroupTitle({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    return Scaffold(
      appBar: AppBar(
        title: Text("New Group"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {},
        child: Icon(
          Icons.done,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      body: Column(children: [
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Group Name",
                        prefixIcon: Icon(Icons.group),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: groupController.groupMembers
                  .map(
                    (e) => ChatTile(
                        imageUrl:
                            e.profileImage ?? Assetimage.defultprofileImage,
                        name: e.name!,
                        lastChat: e.about ?? '',
                        lastTime: ""),
                  )
                  .toList(),
            ),
          ),
        ),
      ]),
    );
  }
}
