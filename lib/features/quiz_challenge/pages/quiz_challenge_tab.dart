import 'package:flutter/material.dart';

class QuizChallengeTab extends StatelessWidget {
  const QuizChallengeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Challenge',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Challenge yourself with quick questions based on your completed lessons!',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
