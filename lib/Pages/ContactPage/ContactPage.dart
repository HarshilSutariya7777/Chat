import 'package:chatapp3/Controller/ContactController.dart';
import 'package:chatapp3/Controller/ProfileController.dart';
import 'package:chatapp3/Pages/Chat/ChatPage.dart';
import 'package:chatapp3/Pages/ContactPage/Widget/ContactSearch.dart';
import 'package:chatapp3/Pages/ContactPage/Widget/NewContactTile.dart';
import 'package:chatapp3/Pages/Groups/NewGroup/NewGroup.dart';
import 'package:chatapp3/Pages/HomePage/widget/ChatTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chatapp3/Config/Images.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isSearchEnable = false.obs;
    ContactController contactController = Get.put(ContactController());
    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select contact"),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                isSearchEnable.value = !isSearchEnable.value;
              },
              icon: isSearchEnable.value
                  ? const Icon(Icons.close)
                  : const Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Obx(
              () => isSearchEnable.value
                  ? const ContactSearch()
                  : const SizedBox(),
            ),
            const SizedBox(height: 10),
            NewContactTile(
              btnName: "New Contact",
              icon: Icons.person_add,
              ontap: () {},
            ),
            const SizedBox(height: 20),
            NewContactTile(
              btnName: "New Group",
              icon: Icons.group_add,
              ontap: () {
                Get.to(const NewGroup());
              },
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Text("Contacts on Samepark"),
              ],
            ),
            const SizedBox(height: 10),
            Obx(
              () => Column(
                children: contactController.userList
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          Get.to(ChatPage(userModel: e));
                        },
                        child: ChatTile(
                          imageUrl:
                              e.profileImage ?? Assetimage.defultprofileImage,
                          name: e.name ?? "User",
                          lastChat: e.about ?? "Hey there",
                          lastTime: e.email ==
                                  profileController.currentUser.value.email
                              ? "You"
                              : "",
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
