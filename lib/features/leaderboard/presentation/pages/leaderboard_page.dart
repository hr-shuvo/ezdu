import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Leaderboard page")),
      body: Column(
        children: [
          Text("User 1"),
          const SizedBox(height: 8),
          Text("User 2"),
          const SizedBox(height: 8),
          Text("User 2"),
        ],
      ),
    );
  }
}
