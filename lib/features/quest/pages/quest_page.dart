import 'package:ezdu/features/quest/models/quest_model.dart';
import 'package:ezdu/features/quest/widgets/quest_card.dart';
import 'package:flutter/material.dart';


// ============= DUMMY DATA =============
final List<QuestModel> dailyQuests = [
  QuestModel(
    id: 'd1',
    title: 'Complete 3 Lessons',
    description: 'Finish any 3 lessons today',
    xpReward: 50,
    currentProgress: 2,
    targetProgress: 3,
    type: QuestType.daily,
    icon: Icons.school,
    color: const Color(0xFF4CAF50),
    completed: false,
  ),
  QuestModel(
    id: 'd2',
    title: 'Start a Streak',
    description: 'Complete 1 lesson to start your daily streak',
    xpReward: 30,
    currentProgress: 0,
    targetProgress: 1,
    type: QuestType.daily,
    icon: Icons.local_fire_department,
    color: const Color(0xFFFF6B35),
    completed: false,
  ),
  QuestModel(
    id: 'd3',
    title: 'Score 80% in 2 Lessons',
    description: 'Achieve 80% accuracy or higher in 2 lessons',
    xpReward: 75,
    currentProgress: 1,
    targetProgress: 2,
    type: QuestType.daily,
    icon: Icons.trending_up,
    color: const Color(0xFF2196F3),
    completed: false,
  ),
  QuestModel(
    id: 'd4',
    title: 'Get 10 in a Row',
    description: 'Answer 10 questions correctly in a row',
    xpReward: 100,
    currentProgress: 7,
    targetProgress: 10,
    type: QuestType.daily,
    icon: Icons.check_circle,
    color: const Color(0xFF9C27B0),
    completed: false,
  ),
  QuestModel(
    id: 'd5',
    title: 'Earn 100 XP',
    description: 'Accumulate 100 XP throughout the day',
    xpReward: 40,
    currentProgress: 85,
    targetProgress: 100,
    type: QuestType.daily,
    icon: Icons.flash_on,
    color: const Color(0xFFFFC107),
    completed: false,
  ),
  QuestModel(
    id: 'd6',
    title: 'Perfect Lesson',
    description: 'Complete 1 lesson with 100% accuracy',
    xpReward: 60,
    currentProgress: 0,
    targetProgress: 1,
    type: QuestType.daily,
    icon: Icons.star,
    color: const Color(0xFFE91E63),
    completed: false,
  ),
  QuestModel(
    id: 'd7',
    title: 'Try 3 Different Topics',
    description: 'Practice lessons from 3 different subjects',
    xpReward: 55,
    currentProgress: 1,
    targetProgress: 3,
    type: QuestType.daily,
    icon: Icons.category,
    color: const Color(0xFF00BCD4),
    completed: false,
  ),
  QuestModel(
    id: 'd8',
    title: 'Speed Runner',
    description: 'Complete 2 lessons in under 5 minutes each',
    xpReward: 45,
    currentProgress: 1,
    targetProgress: 2,
    type: QuestType.daily,
    icon: Icons.bolt,
    color: const Color(0xFF00E676),
    completed: false,
  ),
];

final List<QuestModel> weeklyQuests = [
  QuestModel(
    id: 'w1',
    title: 'Weekly Warrior - Earn 500 XP',
    description: 'Accumulate 500 XP throughout the week',
    xpReward: 200,
    currentProgress: 340,
    targetProgress: 500,
    type: QuestType.weekly,
    icon: Icons.shield,
    color: const Color(0xFF4CAF50),
    completed: false,
  ),
  QuestModel(
    id: 'w2',
    title: '5-Day Streak',
    description: 'Complete lessons for 5 consecutive days',
    xpReward: 150,
    currentProgress: 3,
    targetProgress: 5,
    type: QuestType.weekly,
    icon: Icons.local_fire_department,
    color: const Color(0xFFFF6B35),
    completed: false,
  ),
  QuestModel(
    id: 'w3',
    title: 'Master 10 Lessons',
    description: 'Complete and master 10 lessons (80%+ score)',
    xpReward: 250,
    currentProgress: 6,
    targetProgress: 10,
    type: QuestType.weekly,
    icon: Icons.workspace_premium,
    color: const Color(0xFF2196F3),
    completed: false,
  ),
  QuestModel(
    id: 'w4',
    title: 'The Collector',
    description: 'Complete 20 lessons this week',
    xpReward: 180,
    currentProgress: 12,
    targetProgress: 20,
    type: QuestType.weekly,
    icon: Icons.collections,
    color: const Color(0xFF9C27B0),
    completed: false,
  ),
  QuestModel(
    id: 'w5',
    title: 'Perfect Week',
    description: 'Complete 3 lessons with 100% accuracy',
    xpReward: 300,
    currentProgress: 1,
    targetProgress: 3,
    type: QuestType.weekly,
    icon: Icons.star,
    color: const Color(0xFFFFC107),
    completed: false,
  ),
  QuestModel(
    id: 'w6',
    title: 'Consistency Champion',
    description: 'Spend at least 30 minutes practicing each day',
    xpReward: 200,
    currentProgress: 4,
    targetProgress: 7,
    type: QuestType.weekly,
    icon: Icons.hourglass_full,
    color: const Color(0xFFE91E63),
    completed: false,
  ),
  QuestModel(
    id: 'w7',
    title: 'Social Butterfly',
    description: 'Challenge 5 friends to lessons',
    xpReward: 175,
    currentProgress: 2,
    targetProgress: 5,
    type: QuestType.weekly,
    icon: Icons.people,
    color: const Color(0xFF00BCD4),
    completed: false,
  ),
  QuestModel(
    id: 'w8',
    title: 'Legend Status',
    description: 'Get 50 correct answers in a row throughout the week',
    xpReward: 350,
    currentProgress: 28,
    targetProgress: 50,
    type: QuestType.weekly,
    icon: Icons.flash_on,
    color: const Color(0xFF00E676),
    completed: false,
  ),
];

class QuestPage extends StatelessWidget {
  const QuestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EzDu Quests',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const QuestPageHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ============= QUEST PAGE HOME =============
class QuestPageHome extends StatefulWidget {
  const QuestPageHome({Key? key}) : super(key: key);

  @override
  State<QuestPageHome> createState() => _QuestPageHomeState();
}

class _QuestPageHomeState extends State<QuestPageHome> {
  late List<QuestModel> dailyQuestsList;
  late List<QuestModel> weeklyQuestsList;
  int totalDailyXP = 0;
  int totalWeeklyXP = 0;

  @override
  void initState() {
    super.initState();
    dailyQuestsList = dailyQuests;
    weeklyQuestsList = weeklyQuests;
    _calculateTotalXP();
  }

  void _calculateTotalXP() {
    totalDailyXP = dailyQuestsList
        .where((q) => q.isComplete)
        .fold(0, (sum, q) => sum + q.xpReward);
    totalWeeklyXP = weeklyQuestsList
        .where((q) => q.isComplete)
        .fold(0, (sum, q) => sum + q.xpReward);
  }

  void _completeQuest(QuestModel quest) {
    setState(() {
      final index = quest.type == QuestType.daily
          ? dailyQuestsList.indexWhere((q) => q.id == quest.id)
          : weeklyQuestsList.indexWhere((q) => q.id == quest.id);

      if (index != -1) {
        final questList =
        quest.type == QuestType.daily ? dailyQuestsList : weeklyQuestsList;
        questList[index] = QuestModel(
          id: quest.id,
          title: quest.title,
          description: quest.description,
          xpReward: quest.xpReward,
          currentProgress: quest.targetProgress,
          targetProgress: quest.targetProgress,
          type: quest.type,
          icon: quest.icon,
          color: quest.color,
          completed: true,
        );
        _calculateTotalXP();
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('QuestModel completed! +${quest.xpReward} XP'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quests & Challenges'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total XP Card
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepPurple.shade400,
                      Colors.deepPurple.shade700,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
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
                          'Today\'s XP',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$totalDailyXP XP',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 50,
                      color: Colors.white30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'This Week',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$totalWeeklyXP XP',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Daily Quests Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                '📅 Daily Quests',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: dailyQuestsList
                    .map((quest) => QuestCard(
                  quest: quest,
                  onComplete: () => _completeQuest(quest),
                ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),
            // Weekly Quests Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                '📊 Weekly Challenges',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: weeklyQuestsList
                    .map((quest) => QuestCard(
                  quest: quest,
                  onComplete: () => _completeQuest(quest),
                ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

