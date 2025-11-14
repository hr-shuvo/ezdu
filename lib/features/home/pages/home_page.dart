import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/models/quiz_model.dart';
import 'package:ezdu/data/repositories/quiz_repository.dart';
import 'package:ezdu/features/home/widgets/daily_quiz_card.dart';
import 'package:ezdu/features/home/widgets/home_grid_section.dart';
import 'package:ezdu/features/home/widgets/mini_leaderboard.dart';
import 'package:ezdu/features/home/widgets/quic_challenge_card.dart';
import 'package:ezdu/features/home/widgets/recommended_section.dart';
import 'package:ezdu/features/home/widgets/upcoming_quiz_card.dart';
import 'package:ezdu/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, required this.quizRepository});

  final QuizRepository quizRepository;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late Future<ApiResponse<QuizModel>> upcomingQuizFuture;

  @override
  void initState() {
    super.initState();
    upcomingQuizFuture = widget.quizRepository.getUpcomingQuiz();
  }

  @override
  Widget build(BuildContext context) {
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
                  // Icon(Icons.local_fire_department_outlined, size: 24),
                  Image.asset('assets/icons/fire.png', height: 24, width: 24),
                  SizedBox(width: 4),
                  Text(isLoggedIn ? '75' : '1', style: TextStyle(fontSize: 14)),
                ],
              ),

              Row(
                children: [
                  // Icon(Icons.star_outline, size: 24),
                  Image.asset('assets/icons/storm.png', height: 24, width: 24),
                  SizedBox(width: 4),
                  Text(
                    isLoggedIn ? '20' : '10',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/diamond.png',
                    height: 24,
                    width: 24,
                  ),
                  SizedBox(width: 4),
                  Text(
                    isLoggedIn ? '12' : '50',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),

              Row(
                children: [
                  Image.asset('assets/icons/medal.png', height: 24, width: 24),
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

                FutureBuilder(
                  future: upcomingQuizFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: Text('Loading...'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (snapshot.hasData && snapshot.data!.data != null) {
                      return UpcomingQuizCard(
                        isLoggedIn: isLoggedIn,
                        quiz: snapshot.data!.data!,
                      );
                    }

                    return SizedBox.shrink();
                  },
                ),

                if (!isLoggedIn) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.errorContainer,
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
