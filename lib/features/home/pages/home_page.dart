import 'package:ezdu/features/home/widgets/daily_quiz_card.dart';
import 'package:ezdu/features/home/widgets/home_grid_section.dart';
import 'package:ezdu/features/home/widgets/mini_leaderboard.dart';
import 'package:ezdu/features/home/widgets/quic_challenge_card.dart';
import 'package:ezdu/features/home/widgets/recommended_section.dart';
import 'package:ezdu/features/home/widgets/upcoming_quiz_card.dart';
import 'package:ezdu/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.read(authProvider).isLoggedIn();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return PopScope(
      canPop: !isLoggedIn,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,

          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.local_fire_department_outlined, size: 24),
                  SizedBox(width: 4),
                  Text(isLoggedIn ? '75' : '1', style: TextStyle(fontSize: 14)),
                ],
              ),

              Row(
                children: [
                  Icon(Icons.star_outline, size: 24),
                  SizedBox(width: 4),
                  Text(isLoggedIn ? '20' : '10', style: TextStyle(fontSize: 14)),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.diamond_outlined, size: 24),
                  SizedBox(width: 4),
                  Text(isLoggedIn ? '12' : '50', style: TextStyle(fontSize: 14)),
                ],
              ),

              Row(
                children: const [
                  Icon(Icons.workspace_premium_outlined, size: 24),
                  SizedBox(width: 4),
                  Text('Pro', style: TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            // todo: reload related data
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                if (isLoggedIn) ...[DailyQuizCard(), SizedBox(height: 16)],
                UpcomingQuizCard(isLoggedIn: isLoggedIn),

                if (!isLoggedIn) ...[
                  SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.errorContainer, // Use an attention-grabbing, themed color
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lock_outline,
                          color: colorScheme.onErrorContainer,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'You must be logged in to access all features',
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onErrorContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                HomeGridSection(isLoggedIn: isLoggedIn),
                SizedBox(height: 16),
                RecommendedSection(),
                SizedBox(height: 16),
                MiniLeaderboardRow(),
                SizedBox(height: 16),
                QuickChallengeCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
