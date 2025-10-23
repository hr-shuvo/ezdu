import 'package:flutter/material.dart';

class QuestPage extends StatelessWidget {
  const QuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quest page")),
      body: Column(
        children: [
          Text("Quest 1"),
          const SizedBox(height: 8),
          Text("Quest 2"),
          const SizedBox(height: 8),
          Text("Quest 2"),
        ],
      ),
    );
  }
}
