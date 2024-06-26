import 'package:flutter/material.dart';

MyTabBar(TabController tabController, BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: TabBar(
        controller: tabController,
        indicatorWeight: 4,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: Theme.of(context).textTheme.bodyLarge,
        unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
        tabs: [
          Text("Chats"),
          Text("Groups"),
          Text("Calls"),
        ]),
  );
}
