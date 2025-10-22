import 'package:flutter/material.dart';

class UpcomingQuizCard extends StatelessWidget {
  const UpcomingQuizCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      // color: colorScheme.secondaryContainer.withValues(alpha: .1),
      child: ListTile(
        leading: const Icon(Icons.schedule, size: 32),
        title: const Text('Next Quiz: General Knowledge'),
        subtitle: const Text('Starts in 2h 30m'),
        trailing: Icon(Icons.arrow_forward_ios, color: colorScheme.outline, size: 18),
        onTap: () {},
      ),
    );
  }
}