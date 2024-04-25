import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Controller/ChatController.dart';
import 'package:chatapp3/Controller/GroupController.dart';
import 'package:chatapp3/Controller/ProfileController.dart';
import 'package:chatapp3/Model/GroupModel.dart';
import 'package:chatapp3/Pages/Chat/widget/ChatBubble.dart';
import 'package:chatapp3/Pages/GroupChat/GroupTypeMessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GroupChatPage extends StatelessWidget {
  final GroupModel groupModel;
  const GroupChatPage({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    GroupController groupController = Get.put(GroupController());
    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              // Get.to(UserProfilePage(
              //   userModel: userModel,
              // ));
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: groupModel.profileUrl == ""
                          ? Assetimage.defultprofileImage
                          : groupModel.profileUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  )),
            )),
        title: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            // Get.to(UserProfilePage(
            //   userModel: userModel,
            // ));
          },
          child: Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  groupModel.name ?? "Group Name",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "Online",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ]),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.phone),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.video_call),
          ),
        ],
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: TypeMessage(userModel: userModel),
      body: Padding(
        padding: EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  StreamBuilder(
                    stream: groupController.getGroupMessages(groupModel.id!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Error:${snapshot.error}"),
                        );
                      }
                      if (snapshot.data == null) {
                        return Center(
                          child: Text("No Messages"),
                        );
                      } else {
                        return ListView.builder(
                            reverse: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              //format date
                              DateTime timestamp = DateTime.parse(
                                  snapshot.data![index].timestamp!);
                              String formattedTime =
                                  DateFormat("hh:mm a").format(timestamp);
                              return ChatBubble(
                                  message: snapshot.data![index].message!,
                                  isComming: snapshot.data![index].senderId !=
                                      profileController.currentUser.value.id,
                                  time: formattedTime,
                                  status: "read",
                                  imageUrl:
                                      snapshot.data![index].imageUrl ?? "");
                            });
                      }
                    },
                  ),
                  Obx(
                    () => (chatController.selectedImagePath.value != "")
                        ? Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: FileImage(
                                          File(chatController
                                              .selectedImagePath.value),
                                        ),
                                        fit: BoxFit.contain,
                                      )),
                                  height: 500,
                                ),
                                Positioned(
                                  right: 0,
                                  child: IconButton(
                                    onPressed: () {
                                      chatController.selectedImagePath.value =
                                          "";
                                    },
                                    icon: Icon(Icons.close),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
            GroupTypeMessage(groupModel: groupModel),
          ],
        ),
      ),
    );
  }
}