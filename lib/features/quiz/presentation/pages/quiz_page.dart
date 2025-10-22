import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz page")),
      body: Column(
        children: [
          Text("Quiz 1"),
          const SizedBox(height: 8),
          Text("Quiz 2"),
          const SizedBox(height: 8),
          Text("Quiz 2"),
        ],
      ),
    );
  }
}
