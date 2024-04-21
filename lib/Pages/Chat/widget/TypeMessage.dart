import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Controller/ChatController.dart';
import 'package:chatapp3/Model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TypeMessage extends StatelessWidget {
  final UserModel userModel;
  const TypeMessage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    TextEditingController messageController = TextEditingController();
    RxString message = "".obs;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            child: Icon(Icons.emoji_emotions_outlined),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: (value) {
                message.value = value;
              },
              controller: messageController,
              decoration:
                  InputDecoration(filled: false, hintText: "Type message ..."),
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
          Obx(
            () => message.value == ""
                ? SvgPicture.asset(
                    Assetimage.chatMicSVG,
                    width: 25,
                  )
                : InkWell(
                    onTap: () {
                      if (messageController.text.isNotEmpty) {
                        chatController.sendMessage(
                            userModel.id!, messageController.text, userModel);
                        messageController.clear();
                        message.value = "";
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
          ),
        ],
      ),
    );
  }
}
