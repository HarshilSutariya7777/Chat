import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Pages/Chat/widget/ChatBubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(Assetimage.boyPic),
        ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Harshil Sutariya",
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
              Container(
                width: 30,
                height: 30,
                child: SvgPicture.asset(
                  Assetimage.chatSendSVG,
                  width: 25,
                ),
              ),
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            ChatBubble(
                message: "Hello",
                imageUrl: "",
                isComming: true,
                status: "read",
                time: "10:10 AM"),
            ChatBubble(
                message: "Hello",
                imageUrl: "",
                isComming: false,
                status: "read",
                time: "10:10 AM"),
            ChatBubble(
                message: "Hello",
                imageUrl:
                    "https://assets-global.website-files.com/5f841209f4e71b2d70034471/60bb4a2e143f632da3e56aea_Flutter%20app%20development%20(2).png",
                isComming: false,
                status: "read",
                time: "10:10 AM"),
            ChatBubble(
                message: "Hello",
                imageUrl: "",
                isComming: true,
                status: "read",
                time: "10:10 AM"),
          ],
        ),
      ),
    );
  }
}
