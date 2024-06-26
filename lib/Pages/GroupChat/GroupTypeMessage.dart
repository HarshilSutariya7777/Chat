// ignore_for_file: prefer_const_constructors

import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Controller/GroupController.dart';
import 'package:chatapp3/Controller/ImagePickerController.dart';
import 'package:chatapp3/Model/GroupModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class GroupTypeMessage extends StatelessWidget {
  final GroupModel groupModel;
  const GroupTypeMessage({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    // ChatController chatController = Get.put(ChatController());
    TextEditingController messageController = TextEditingController();
    GroupController groupController = Get.put(GroupController());
    RxString message = "".obs;
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: Row(
        children: [
          SizedBox(
            height: 30,
            width: 30,
            child: const Icon(Icons.emoji_emotions_outlined),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: (value) {
                message.value = value;
              },
              controller: messageController,
              decoration: const InputDecoration(
                  filled: false, hintText: "Type message ..."),
            ),
          ),
          const SizedBox(width: 10),
          Obx(
            () => groupController.selectedImagePath.value == ""
                ? InkWell(
                    onTap: () {
                      // ImagePickerBottomSheet(
                      //     context,
                      //     groupController.selectedImagePath,
                      //     imagePickerController);
                    },
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        Assetimage.chatGalarySVG,
                        width: 25,
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
          const SizedBox(width: 10),
          Obx(() => message.value != "" ||
                  groupController.selectedImagePath.value != ""
              ? InkWell(
                  onTap: () {
                    groupController.sendGroupMessage(
                        messageController.text, groupModel.id!, "");
                    messageController.clear();
                    message.value = "";
                  },
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: groupController.isLoading.value
                        ? const CircularProgressIndicator()
                        : SvgPicture.asset(
                            Assetimage.chatSendSVG,
                            width: 25,
                          ),
                  ),
                )
              : SvgPicture.asset(
                  Assetimage.chatMicSVG,
                  width: 25,
                )),
        ],
      ),
    );
  }
}
