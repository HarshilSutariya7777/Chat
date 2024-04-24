import 'package:chatapp3/Config/Images.dart';
import 'package:chatapp3/Controller/ContactController.dart';
import 'package:chatapp3/Pages/HomePage/widget/ChatTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewGroup extends StatelessWidget {
  const NewGroup({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    return Scaffold(
      appBar: AppBar(
        title: Text("New Group"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.arrow_forward),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder(
          stream: contactController.getContacts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Error:${snapshot.error}"),
              );
            }
            if (snapshot.data == null) {
              return Center(
                child: Text("No Messages"),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ChatTile(
                        imageUrl: snapshot.data![index].profileImage ??
                            Assetimage.defultprofileImage,
                        name: snapshot.data![index].name!,
                        lastChat: snapshot.data![index].about! ?? "",
                        lastTime: "");
                  });
            }
          },
        ),
      ),
    );
  }
}
