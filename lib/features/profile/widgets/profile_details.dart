import 'package:ezdu/core/utils/helpers.dart';
import 'package:ezdu/features/profile/models/achievement.dart';
import 'package:ezdu/features/profile/models/progress.dart';
import 'package:ezdu/features/profile/widgets/profile_overview.dart';
import 'package:ezdu/features/profile/widgets/xp_bar_chart.dart';
import 'package:flutter/material.dart';

class UserDetailsWidget extends StatelessWidget {
  final String displayName;
  final String username;
  final String joinedDate;
  final String profileImageUrl;
  final int followers;
  final int following;
  final int totalXP;
  final int currentStreak;
  final int level;
  final int totalQuizzes;
  final bool isFollowing;
  final bool isMyself;
  final VoidCallback onFollowPressed;
  final VoidCallback onFriendPressed;
  final List<Map<String, dynamic>> lastQuizzes;

  const UserDetailsWidget({
    super.key,
    required this.displayName,
    required this.username,
    required this.joinedDate,
    required this.profileImageUrl,
    required this.followers,
    required this.following,
    required this.totalXP,
    required this.currentStreak,
    required this.level,
    required this.totalQuizzes,
    required this.isFollowing,
    required this.isMyself,
    required this.onFollowPressed,
    required this.onFriendPressed,
    required this.lastQuizzes,
  });

  @override
  Widget build(BuildContext context) {
    final itemWidth = (MediaQuery.of(context).size.width - 16 - 16) / 2;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Text(
              '@$username - Joined ${TimeHelper.formatUtcToLocalMonth(joinedDate)}'
                  .toUpperCase(),
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Following/Followers Stats
          Row(
            children: [
              _buildStatItem('Following', following),
              const SizedBox(width: 24),
              _buildStatItem('Followers', followers),
            ],
          ),
          const SizedBox(height: 16),

          // Action Buttons
          Row(
            children: [
              isMyself
                  ? Expanded(
                      child: _buildActionButton(
                        label: 'Add Friends',
                        onPressed: () {},
                        isPrimary: false,
                      ),
                    )
                  : Expanded(
                      child: _buildActionButton(
                        label: isFollowing ? 'Unfollow' : 'Follow',
                        onPressed: onFollowPressed,
                        isPrimary: !isFollowing,
                      ),
                    ),
            ],
          ),
          const SizedBox(height: 16),
          ProfileOverView(
            currentStreak: currentStreak,
            totalXp: totalXP,
            quizCount: 23,
          ),

          const SizedBox(height: 16),

          // Weekly Stats
          Text(
            'Weekly Activity',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          XPBarChart(data: progress.weeklyData),

          const SizedBox(height: 24),

          // Last Quizzes Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Last Quizzes',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(onPressed: () {}, child: const Text('View All')),
                ],
              ),
              const SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: lastQuizzes.take(3).length,
                itemBuilder: (context, index) {
                  final quiz = lastQuizzes[index];
                  return _buildQuizCard(quiz);
                },
              ),
            ],
          ),
          const SizedBox(height: 24),

          const SizedBox(height: 24),
          // Achievements
          const Text(
            'Recent Achievements',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...progress.achievements.map((achievement) {
            return _AchievementTile(achievement: achievement);
          }),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required VoidCallback onPressed,
    required bool isPrimary,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? Colors.green : Colors.transparent,
        // foregroundColor: isPrimary ? Colors.white : Colors.black54,
        padding: const EdgeInsets.symmetric(vertical: 12),
        elevation: isPrimary ? 2 : 0,
        side: isPrimary
            ? BorderSide.none
            : const BorderSide(color: Colors.grey, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(label),
    );
  }

  Widget _buildQuizCard(Map<String, dynamic> quiz) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quiz['title'] ?? 'Quiz',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  quiz['date'] ?? 'Today',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _getScoreColor(quiz['score'] as int),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${quiz['score']}%',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.orange;
    return Colors.red;
  }
}

class _AchievementTile extends StatelessWidget {
  final Achievement achievement;

  const _AchievementTile({required this.achievement});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.emoji_events,
              color: Colors.amber,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  achievement.description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '+${achievement.xp} XP',
              style: const TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final progress = Progress(
  totalXP: 4233,
  currentStreak: 27,
  weeklyData: [
    DailyProgress(day: '21/07/25', xp: 32),
    DailyProgress(day: '24/07/25', xp: 58),
  ],
  achievements: [
    Achievement(
      id: 1,
      title: 'First Step',
      description: 'Complete your first lesson',
      xp: 50,
      unlockedAt: DateTime.utc(2025, 1, 1),
    ),
    Achievement(
      id: 2,
      title: 'Quiz Master',
      description: 'Score 100% in a quiz',
      xp: 100,
      unlockedAt: DateTime.utc(2025, 2, 10),
    ),
    Achievement(
      id: 3,
      title: "title",
      description: "description",
      xp: 66,
      unlockedAt: DateTime.utc(2025, 2, 10),
    ),
    Achievement(
      id: 4,
      title: 'Daily Streak',
      description: 'Maintain a 7-day streak',
      xp: 150,
      unlockedAt: DateTime.utc(2025, 3, 5),
    ),
    Achievement(
      id: 5,
      title: 'XP Collector',
      description: 'Earn over 1000 XP total',
      xp: 200,
      unlockedAt: DateTime.utc(2025, 3, 15),
    ),
  ],
);
