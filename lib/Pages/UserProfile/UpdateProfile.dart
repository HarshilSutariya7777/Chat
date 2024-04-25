import 'package:chatapp3/Widget/PrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserUpdateProfile extends StatelessWidget {
  const UserUpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primaryContainer),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            child: Center(
                              child: Icon(
                                Icons.image,
                                size: 40,
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                "Personal Info",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                "Name",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          TextField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                hintText: "Name"),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                "Email Id",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          TextField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.alternate_email_rounded),
                                hintText: "Example@gmail.com"),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                "Phone Number",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          TextField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                hintText: "1234567891"),
                          ),
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PrimaryButton(
                                btnName: "Save",
                                icon: Icons.save,
                                ontap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
