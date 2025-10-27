import 'package:ezdu/features/auth/pages/login_page.dart';
import 'package:ezdu/features/auth/pages/register_page.dart';
import 'package:ezdu/features/quiz/pages/quiz_page.dart';
import 'package:flutter/material.dart';

class UpcomingQuizCard extends StatelessWidget {
  const UpcomingQuizCard({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),

        border: Border.all(
          color: colorScheme.onPrimaryContainer.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onPrimaryContainer.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        // Ensure splash color is visible over the surface color
        splashColor: colorScheme.onSurface.withOpacity(0.1),

        leading: Icon(
          Icons.schedule,
          size: 32,
          // Use a contrasting color, like secondary or tertiary, for icons
          color: colorScheme.secondary,
        ),
        title: Text(
          'Next Quiz: General Knowledge',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            // Text color readable ON the surface color
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          'Starts in 2h 30m',
          style: theme.textTheme.bodyMedium?.copyWith(
            // Subtler color, using onSurface with opacity
            color: colorScheme.onSurface.withOpacity(0.8),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          // Match the leading icon color
          color: colorScheme.secondary,
          size: 20,
        ),
        onTap: () {
          final navigator = Navigator.of(context);

          if (isLoggedIn) {
            navigator.push(
              MaterialPageRoute(
                builder: (context) =>
                    const QuizPage(),
              ),
            );
          } else {
            navigator.push(
              MaterialPageRoute(
                builder: (context) =>
                    const RegisterPage(),
              ),
            );
          }
        },
      ),
    );
  }
}
