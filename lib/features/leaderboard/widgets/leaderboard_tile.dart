import 'package:ezdu/features/leaderboard/entities/leaderboard.dart';
import 'package:flutter/material.dart';

class LeaderboardTile extends StatelessWidget {
  final LeaderboardEntry entry;
  final int rank;
  final bool isTopThree;

  const LeaderboardTile({
    super.key,
    required this.entry,
    required this.rank,
    required this.isTopThree,
  });

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey;
      case 3:
        return Colors.brown;
      default:
        return Colors.blue;
    }
  }

  IconData _getRankIcon(int rank) {
    if (rank <= 3) return Icons.emoji_events;
    return Icons.person;
  }

  @override
  Widget build(BuildContext context) {
    final rankColor = _getRankColor(rank);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // color: Colors.white,
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isTopThree ? rankColor.withOpacity(0.3) : Colors.grey.shade200,
          width: isTopThree ? 2 : 1,
        ),
        boxShadow: isTopThree
            ? [
          BoxShadow(
            color: rankColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ]
            : null,
      ),
      child: Row(
        children: [
          // Rank Badge
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: rankColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: isTopThree
                  ? Icon(
                _getRankIcon(rank),
                color: rankColor,
                size: 24,
              )
                  : Text(
                '$rank',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: rankColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // User Avatar
          CircleAvatar(
            radius: 24,
            backgroundColor: Theme.of(context).primaryColor.withValues(alpha: .1),
            child: Text(
              entry.userName.isNotEmpty
                  ? entry.userName[0].toUpperCase()
                  : 'U',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.userName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.local_fire_department,
                      size: 14,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${entry.streak} day streak',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // XP Score
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: rankColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(Icons.stars, color: rankColor, size: 18),
                const SizedBox(width: 4),
                Text(
                  '${entry.xp}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: rankColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}