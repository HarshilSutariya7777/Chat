import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Controller/ChatController.dart';
import 'package:chatapp3/Controller/ProfileController.dart';
import 'package:chatapp3/Model/ChatModel.dart';
import 'package:chatapp3/Model/UserModel.dart';
import 'package:chatapp3/Pages/Chat/widget/ChatBubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatelessWidget {
  final UserModel userModel;
  const ChatPage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    TextEditingController messageController = TextEditingController();
    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(Assetimage.boyPic),
        ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            userModel.name ?? "User",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            "Online",
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ]),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Theme.of(context).colorScheme.primaryContainer),
          child: Row(
            children: [
              SvgPicture.asset(
                Assetimage.chatMicSVG,
                width: 25,
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                      filled: false, hintText: "Type message ..."),
                ),
              ),
              SizedBox(width: 10),
              Container(
                height: 30,
                width: 30,
                child: SvgPicture.asset(
                  Assetimage.chatGalarySVG,
                  width: 25,
                ),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  // var newChat = ChatModel(
                  //   id: DateTime.now().millisecondsSinceEpoch.toString(),
                  //   message: messageController.text,
                  //   senderId: chatController.auth.currentUser!.uid,
                  //   receiverId: userModel.id,
                  //   timestamp: DateTime.now().microsecondsSinceEpoch.toString(),
                  // );
                  if (messageController.text.isNotEmpty) {
                    chatController.sendMessage(
                        userModel.id!, messageController.text);
                    messageController.clear();
                  }
                },
                child: Container(
                  width: 30,
                  height: 30,
                  child: SvgPicture.asset(
                    Assetimage.chatSendSVG,
                    width: 25,
                  ),
                ),
              ),
            ],
          )),
      body: Padding(
        padding: EdgeInsets.only(bottom: 70, top: 10, left: 10, right: 10),
        child: StreamBuilder<List<ChatModel>>(
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
                      DateTime timestamp =
                          DateTime.parse(snapshot.data![index].timestamp!);
                      String formattedTime =
                          DateFormat("hh:mm a").format(timestamp);
                      return ChatBubble(
                          message: snapshot.data![index].message!,
                          isComming: snapshot.data![index].receiverId ==
                              profileController.currentUser.value.id,
                          time: formattedTime,
                          status: "read",
                          imageUrl: snapshot.data![index].imageUrl ?? "");
                    });
              }
            }),
      ),
    );
  }
}
