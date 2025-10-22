import 'package:flutter/material.dart';

class MiniLeaderboardRow extends StatelessWidget {
  const MiniLeaderboardRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          LeaderboardCard(user: 'Alice', rank: 1),
          LeaderboardCard(user: 'Bob', rank: 2),
          LeaderboardCard(user: 'Charlie', rank: 3),
          LeaderboardCard(user: 'You', rank: 5),
        ],
      ),
    );
  }
}

class LeaderboardCard extends StatelessWidget {
  final String user;
  final int rank;

  const LeaderboardCard({super.key, required this.user, required this.rank});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '#$rank',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant, // secondary text color
            ),
          ),
        ],
      ),
    );
  }
}
