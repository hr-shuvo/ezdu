import 'package:ezdu/data/repositories/user_quest_repository.dart';
import 'package:ezdu/features/quest/widgets/quest_card.dart';
import 'package:flutter/material.dart';

class QuestPage extends StatelessWidget {
  final UserQuestRepository userQuestRepository;

  const QuestPage({super.key, required this.userQuestRepository});

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
                future: userQuestRepository.getDailyQuestList(),
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
                        return QuestCard(
                          quest: items[index],
                          onComplete: () {},
                        );
                      },
                    );
                  }

                  return SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildXPCard(BuildContext context) {
    int totalDailyXP = 0;
    int totalWeeklyXP = 0;

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
