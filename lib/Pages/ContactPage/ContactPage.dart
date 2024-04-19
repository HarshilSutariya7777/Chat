import 'package:chatapp3/Pages/ContactPage/Widget/ContactSearch.dart';
import 'package:chatapp3/Pages/ContactPage/Widget/NewContactTile.dart';
import 'package:chatapp3/Pages/HomePage/widget/ChatTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chatapp3/Config/Images.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isSearchEnable = false.obs;
    return Scaffold(
      appBar: AppBar(
        title: Text("Select contact"),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                isSearchEnable.value = !isSearchEnable.value;
              },
              icon:
                  isSearchEnable.value ? Icon(Icons.close) : Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Obx(
              () => isSearchEnable.value ? ContactSearch() : SizedBox(),
            ),
            SizedBox(height: 10),
            NewContactTile(
              btnName: "New Contact",
              icon: Icons.person_add,
              ontap: () {},
            ),
            SizedBox(height: 20),
            NewContactTile(
              btnName: "New Group",
              icon: Icons.group_add,
              ontap: () {},
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text("Contacts on Samepark"),
              ],
            ),
            SizedBox(height: 10),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed("/chatPage");
                  },
                  child: ChatTile(
                    imageUrl: Assetimage.girlPic,
                    name: "Harshil Sutariya",
                    lastChat: "Keshe Ho Bhai",
                    lastTime: "08:33 PM",
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed("/chatPage");
                  },
                  child: ChatTile(
                    imageUrl: Assetimage.girlPic,
                    name: "Harshil Sutariya",
                    lastChat: "Keshe Ho Bhai",
                    lastTime: "08:33 PM",
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed("/chatPage");
                  },
                  child: ChatTile(
                    imageUrl: Assetimage.girlPic,
                    name: "Harshil Sutariya",
                    lastChat: "Keshe Ho Bhai",
                    lastTime: "08:33 PM",
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed("/chatPage");
                  },
                  child: ChatTile(
                    imageUrl: Assetimage.girlPic,
                    name: "Harshil Sutariya",
                    lastChat: "Keshe Ho Bhai",
                    lastTime: "08:33 PM",
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed("/chatPage");
                  },
                  child: ChatTile(
                    imageUrl: Assetimage.girlPic,
                    name: "Harshil Sutariya",
                    lastChat: "Keshe Ho Bhai",
                    lastTime: "08:33 PM",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
