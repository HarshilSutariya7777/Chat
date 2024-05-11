import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Pages/VideoPlayer/Videoplayer.dart';
import 'package:chatapp3/Widget/FullScreenImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isComming;
  final String time;
  final String status;
  final String imageUrl;
  final String vidoUrl;
  final Function()? onReplay;
  const ChatBubble({
    Key? key,
    required this.message,
    required this.isComming,
    required this.time,
    required this.status,
    required this.imageUrl,
    required this.vidoUrl,
    this.onReplay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction:
          isComming ? DismissDirection.endToStart : DismissDirection.startToEnd,
      background: Container(
        color: Colors.blue,
        alignment: isComming ? Alignment.centerRight : Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(
          Icons.reply,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (_) async {
        if (onReplay != null) {
          onReplay!();
          return false;
        }
        return true;
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment:
              isComming ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width / 1.3),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: isComming
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(10),
                      )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(0),
                      ),
              ),
              child: vidoUrl.isNotEmpty
                  ? VideoPlayerWidget(videoPath: vidoUrl)
                  : imageUrl == ""
                      ? Text(message)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(FullScreenImagePage(imageUrl: imageUrl));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                            message == ""
                                ? Container()
                                : const SizedBox(height: 10),
                            message == "" ? Container() : Text(message),
                          ],
                        ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment:
                  isComming ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                isComming
                    ? Text(
                        time,
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    : Row(
                        children: [
                          Text(
                            time,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.asset(
                            Assetimage.chatStatusSVG,
                            width: 20,
                          ),
                        ],
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
