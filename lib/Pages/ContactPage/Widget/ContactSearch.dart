import 'package:flutter/material.dart';

class ContactSearch extends StatelessWidget {
  const ContactSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(children: [
        Expanded(
          child: TextField(
            textInputAction: TextInputAction.done,
            onSubmitted: (value) {
              print(value);
            },
            decoration: InputDecoration(
              hintText: "Search Contact",
              prefixIcon: Icon(Icons.search),
            ),
          ),
        )
      ]),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
}
