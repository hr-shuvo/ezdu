import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feed page")),
      body: Column(
        children: [
          Text("Feed 1"),
          const SizedBox(height: 8),
          Text("Feed 2"),
          const SizedBox(height: 8),
          Text("Feed 2"),
        ],
      ),
    );
  }
}
