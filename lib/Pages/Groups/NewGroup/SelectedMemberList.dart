import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Controller/GroupController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedMemberList extends StatelessWidget {
  const SelectedMemberList({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    return Obx(
      () => Row(
        children: groupController.groupMembers
            .map((e) => Stack(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      margin: EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl:
                              e.profileImage ?? Assetimage.defultprofileImage,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: InkWell(
                        onTap: () {
                          groupController.groupMembers.remove(e);
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100)),
                          child: Icon(
                            Icons.close,
                            size: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ))
            .toList(),
      ),
    );
  }
}
