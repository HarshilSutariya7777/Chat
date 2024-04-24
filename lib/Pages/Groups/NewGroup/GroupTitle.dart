import 'dart:io';

import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Controller/GroupController.dart';
import 'package:chatapp3/Controller/ImagePickerController.dart';
import 'package:chatapp3/Controller/ProfileController.dart';
import 'package:chatapp3/Pages/HomePage/widget/ChatTile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class GroupTitle extends StatelessWidget {
  const GroupTitle({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    RxString imagePath = "".obs;
    RxBool isEdit = false.obs;
    ProfileController profileController = Get.put(ProfileController());
    RxString groupName = "".obs;
    return Scaffold(
      appBar: AppBar(
        title: Text("New Group"),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          backgroundColor: groupName.isEmpty
              ? Colors.grey
              : Theme.of(context).colorScheme.primary,
          onPressed: () {
            if (groupName.isEmpty) {
              Get.snackbar("Error", "Please Enter Group Name");
            } else {
              groupController.createGroup(groupName.value, imagePath.value);
            }
          },
          child: groupController.isLoading.value
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Icon(
                  Icons.done,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
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
                    Obx(
                      () => InkWell(
                        onTap: () async {
                          imagePath.value = await imagePickerController
                              .pickImage(ImageSource.gallery);

                          print("image picker:" + imagePath.value);
                        },
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: imagePath.value == ""
                              ? Icon(
                                  Icons.group,
                                  size: 40,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(
                                    File(imagePath.value),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      onChanged: (value) {
                        groupName.value = value;
                      },
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
