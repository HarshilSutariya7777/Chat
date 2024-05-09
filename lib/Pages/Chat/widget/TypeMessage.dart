import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Controller/ChatController.dart';
import 'package:chatapp3/Controller/ImagePickerController.dart';
import 'package:chatapp3/Controller/VideoPickerController.dart';
import 'package:chatapp3/Model/UserModel.dart';
import 'package:chatapp3/Widget/ImagePickerBottomsheet.dart';
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
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    VideoPickerController videoPickerController =
        Get.put(VideoPickerController());

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: Row(
        children: [
          const SizedBox(
            height: 30,
            width: 30,
            child: Icon(Icons.emoji_emotions_outlined),
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
            () => chatController.selectedImagePath.value == "" &&
                    chatController.selectedVideoPath.value == ""
                ? InkWell(
                    onTap: () {
                      ImagePickerBottomSheet(
                          context,
                          chatController.selectedImagePath,
                          chatController.selectedVideoPath,
                          imagePickerController,
                          videoPickerController);
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
                  chatController.selectedImagePath.value != "" ||
                  chatController.selectedVideoPath.value != ""
              ? InkWell(
                  onTap: () {
                    if (messageController.text.isNotEmpty ||
                        chatController.selectedImagePath.value.isNotEmpty ||
                        chatController.selectedVideoPath.value.isNotEmpty) {
                      chatController.sendMessage(
                          userModel.id!, messageController.text, userModel);
                      messageController.clear();
                      message.value = "";
                    }
                  },
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: chatController.isLoading.value
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
