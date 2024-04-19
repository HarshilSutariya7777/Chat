import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Config/String.dart';
import 'package:chatapp3/Controller/ImagePickerController.dart';
import 'package:chatapp3/Controller/ProfileController.dart';
import 'package:chatapp3/Pages/HomePage/widget/Tabbar.dart';
import 'package:chatapp3/Pages/HomePage/widget/chatlist.dart';
import 'package:chatapp3/Pages/ProfilePage/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    ProfileController profileController = Get.put(ProfileController());
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          AppString.appName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            Assetimage.appIconSVG,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              imagePickerController.pickImage();
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              // Get.toNamed("/profilePage");
              Get.to(ProfilePage());
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
        bottom: MyTabBar(tabController, context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("/contactPage");
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: TabBarView(controller: tabController, children: [
          ChatList(),
          ListView(
            children: [
              ListTile(
                title: Text("Name Harshil"),
              ),
            ],
          ),
          ListView(
            children: [
              ListTile(
                title: Text("Name Harshil"),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
