import 'package:flutter/material.dart';

class UpcomingQuizCard extends StatelessWidget {
  const UpcomingQuizCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      shadowColor: Colors.black26,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: theme.brightness == Brightness.dark
                ? [
                    Colors.indigo.shade700,
                    Colors.indigo.shade500,
                  ] // dark mode soothing
                : [Colors.lightBlue.shade200, Colors.lightBlue.shade100],
            // light mode pastel
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListTile(
          leading: Icon(
            Icons.schedule,
            size: 32,
            color: theme.brightness == Brightness.dark
                ? Colors.tealAccent
                : Colors.blueAccent,
          ),
          title: Text(
            'Next Quiz: General Knowledge',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black87,
            ),
          ),
          subtitle: Text(
            'Starts in 2h 30m',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.brightness == Brightness.dark
                  ? Colors.white70
                  : Colors.black54,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: theme.brightness == Brightness.dark
                ? Colors.tealAccent
                : Colors.blueAccent,
            size: 20,
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
