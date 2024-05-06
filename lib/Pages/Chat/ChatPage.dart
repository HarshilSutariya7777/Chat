import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Controller/CallController.dart';
import 'package:chatapp3/Controller/ChatController.dart';
import 'package:chatapp3/Controller/ProfileController.dart';
import 'package:chatapp3/Model/ChatModel.dart';
import 'package:chatapp3/Model/UserModel.dart';
import 'package:chatapp3/Pages/CallPage/AudioCallPage.dart';
import 'package:chatapp3/Pages/CallPage/VideoCallPage.dart';
import 'package:chatapp3/Pages/Chat/widget/ChatBubble.dart';
import 'package:chatapp3/Pages/Chat/widget/TypeMessage.dart';
import 'package:chatapp3/Pages/UserProfile/ProfilePage.dart';
import 'package:chatapp3/Pages/VideoPlayer/Videoplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class ChatPage extends StatelessWidget {
  final UserModel userModel;
  const ChatPage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    ProfileController profileController = Get.put(ProfileController());
    CallController callController = Get.put(CallController());
    print("video" + chatController.selectedVideoPath.value);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.to(UserProfilePage(
                userModel: userModel,
              ));
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: userModel.profileImage ??
                          Assetimage.defultprofileImage,
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
            Get.to(UserProfilePage(
              userModel: userModel,
            ));
          },
          child: Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  userModel.name ?? "User",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                StreamBuilder(
                  stream: chatController.getStatus(userModel.id!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text(".........");
                    } else {
                      return Text(
                        snapshot.data!.status ?? "",
                        style: TextStyle(
                            fontSize: 12,
                            color: snapshot.data!.status == "Online"
                                ? Colors.green
                                : Colors.grey),
                      );
                    }
                  },
                )
              ]),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(AudioCallPage(target: userModel));
              callController.callAction(
                  userModel, profileController.currentUser.value, "audio");
            },
            icon: Icon(Icons.phone),
          ),
          IconButton(
            onPressed: () {
              Get.to(VideoCallPage(target: userModel));
              callController.callAction(
                  userModel, profileController.currentUser.value, "video");
            },
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
                  StreamBuilder<List<ChatModel>>(
                    stream: chatController.getMessages(userModel.id!),
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
                                isComming: snapshot.data![index].receiverId ==
                                    profileController.currentUser.value.id,
                                time: formattedTime,
                                status: "read",
                                imageUrl: snapshot.data![index].imageUrl ?? "",
                                vidoUrl: snapshot.data![index].videoUrl ?? "",
                              );
                            });
                      }
                    },
                  ),
                  Obx(
                    () => (chatController.selectedImagePath.value != "" ||
                            chatController.selectedVideoPath.value != "")
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
                                    // image: DecorationImage(
                                    //   image: FileImage(
                                    //     File(chatController
                                    //         .selectedImagePath.value),
                                    //   ),
                                    //   fit: BoxFit.contain,
                                    // ),
                                  ),
                                  child:
                                      chatController.selectedVideoPath.value !=
                                              ""
                                          ? AspectRatio(
                                              aspectRatio: 16 / 9,
                                              child: VideoPlayerWidget(
                                                  videoPath: chatController
                                                      .selectedVideoPath.value))
                                          : Image.file(
                                              File(chatController
                                                  .selectedImagePath.value),
                                              fit: BoxFit.contain,
                                            ),
                                  height: 500,
                                ),
                                Positioned(
                                  right: 0,
                                  child: IconButton(
                                    onPressed: () {
                                      chatController.selectedImagePath.value =
                                          "";
                                      chatController.selectedVideoPath.value =
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
            TypeMessage(userModel: userModel),
          ],
        ),
      ),
    );
  }
}
