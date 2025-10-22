import 'package:flutter/material.dart';

class DailyQuizCard extends StatelessWidget{
  const DailyQuizCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      // color: colorScheme.primaryContainer.withValues(alpha: .2),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Quiz Challenge',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.33, // 1/3 quizzes completed
              color: colorScheme.primary,
              backgroundColor: colorScheme.primary.withValues(alpha: .3),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('3 quizzes today', style: theme.textTheme.bodyMedium),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Start Quiz'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}