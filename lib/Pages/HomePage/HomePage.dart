import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Config/String.dart';
import 'package:chatapp3/Controller/CallController.dart';
import 'package:chatapp3/Controller/ContactController.dart';
import 'package:chatapp3/Controller/StatusController.dart';
import 'package:chatapp3/Pages/Groups/GroupsPage.dart';
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
    ContactController contactController = Get.put(ContactController());
    StatusController statusController = Get.put(StatusController());
    CallController callController = Get.put(CallController());
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
              contactController.getChatRoomList();
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              // Get.toNamed("/profilePage");
              Get.to(const ProfilePage());
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
        bottom: MyTabBar(tabController, context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("/contactPage");
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: TabBarView(controller: tabController, children: [
          ChatList(),
          GroupPage(),
          ListView(
            children: const [
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
