import 'package:ezdu/features/home/presentation/widgets/daily_quiz_card.dart';
import 'package:ezdu/features/home/presentation/widgets/home_grid_section.dart';
import 'package:ezdu/features/home/presentation/widgets/mini_leaderboard.dart';
import 'package:ezdu/features/home/presentation/widgets/quic_challenge_card.dart';
import 'package:ezdu/features/home/presentation/widgets/recommended_section.dart';
import 'package:ezdu/features/home/presentation/widgets/upcoming_quiz_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Icon(Icons.local_fire_department_outlined, size: 24),
                SizedBox(width: 4),
                Text('75', style: TextStyle(fontSize: 14)),
              ],
            ),

            Row(
              children: const [
                Icon(Icons.star_outline, size: 24),
                SizedBox(width: 4),
                Text('20', style: TextStyle(fontSize: 14)),
              ],
            ),
            Row(
              children: const [
                Icon(Icons.diamond_outlined, size: 24),
                SizedBox(width: 4),
                Text('12', style: TextStyle(fontSize: 14)),
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
            children: const[
              DailyQuizCard(),
              SizedBox(height: 16),
              UpcomingQuizCard(),
              SizedBox(height: 16),
              HomeGridSection(),
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
    );
  }


}
