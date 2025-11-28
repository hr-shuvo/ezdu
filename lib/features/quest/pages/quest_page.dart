import 'package:ezdu/data/models/user_quest_model.dart';
import 'package:ezdu/data/repositories/user_quest_repository.dart';
import 'package:ezdu/features/quest/widgets/quest_card.dart';
import 'package:flutter/material.dart';

class QuestPage extends StatefulWidget {
  const QuestPage({super.key, required this.userQuestRepository});

  final UserQuestRepository userQuestRepository;

  @override
  State<QuestPage> createState() => _QuestPageHomeState();
}

class _QuestPageHomeState extends State<QuestPage> {
  late List<UserQuestModel> dailyQuestsList;
  int totalDailyXP = 0;
  int totalWeeklyXP = 0;

  @override
  void initState() {
    super.initState();
    dailyQuestsList = dailyQuests;
    _calculateTotalXP();
  }

  void _calculateTotalXP() {
    totalDailyXP = dailyQuestsList
        .where((q) => q.completed)
        .fold(0, (sum, q) => sum + q.target);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quests & Challenges'),
        elevation: 0,
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _buildXPCard(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '📅 Daily Quests',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FutureBuilder(
                future: widget.userQuestRepository.getDailyQuestList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 32),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (snapshot.hasData && snapshot.data!.data != null) {
                    final items = snapshot.data!.data!.items;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return QuestCard(quest: items[index], onComplete: () {});
                      },
                    );
                  }

                  return SizedBox.shrink();
                },
              ),
            ),
          ),




          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: dailyQuestsList
                    .map((q) => QuestCard(quest: q, onComplete: () {}))
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildXPCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade700],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today's XP",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
              ),
              SizedBox(height: 4),
              Text(
                "$totalDailyXP XP",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(width: 1, height: 50, color: Colors.white30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "This Week",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
              ),
              SizedBox(height: 4),
              Text(
                "$totalWeeklyXP XP",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final List<UserQuestModel> dailyQuests = [
  UserQuestModel(
    userId: 1,
    questId: 1,
    completed: true,
    title: 'Complete 3 Lessons',
    description: 'Finish any 3 lessons today',
    progress: 2,
    target: 3,
  ),
  UserQuestModel(
    userId: 1,
    questId: 2,
    completed: false,
    title: 'Start a Streak',
    description: 'Complete 1 lesson to start your daily streak',
    progress: 0,
    target: 1,
  ),
  UserQuestModel(
    userId: 1,
    questId: 3,
    completed: false,
    title: 'Score 80% in 2 Lessons',
    description: 'Achieve 80% accuracy or higher in 2 lessons',
    progress: 1,
    target: 2,
  ),
  UserQuestModel(
    userId: 1,
    questId: 4,
    completed: false,
    title: 'Get 10 in a Row',
    description: 'Answer 10 questions correctly in a row',
    progress: 7,
    target: 10,
  ),
  UserQuestModel(
    userId: 1,
    questId: 5,
    completed: false,
    title: 'Earn 100 XP',
    description: 'Accumulate 100 XP throughout the day',
    progress: 85,
    target: 100,
  ),
  UserQuestModel(
    userId: 1,
    questId: 6,
    completed: false,
    title: 'Perfect Lesson',
    description: 'Complete 1 lesson with 100% accuracy',
    progress: 0,
    target: 1,
  ),
  UserQuestModel(
    userId: 1,
    questId: 7,
    completed: false,
    title: 'Try 3 Different Topics',
    description: 'Practice lessons from 3 different subjects',
    progress: 1,
    target: 3,
  ),
  UserQuestModel(
    userId: 1,
    questId: 8,
    completed: false,
    title: 'Speed Runner',
    description: 'Complete 2 lessons in under 5 minutes each',
    progress: 1,
    target: 2,
  ),
];
