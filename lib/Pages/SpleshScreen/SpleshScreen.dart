import 'package:flutter/material.dart';

class SpleshScreenPage extends StatelessWidget {
  const SpleshScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Splesh Screen",
            style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}
