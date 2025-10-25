import 'package:ezdu/features/quiz/pages/quiz_challenge_tab.dart';
import 'package:ezdu/features/quiz/pages/quiz_list_tab.dart';
import 'package:ezdu/features/quiz/pages/quiz_mock_tab.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<StatefulWidget> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // bottom: const Text('Quiz Center'),
        // elevation: 0,
        title: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Challenge'),
            Tab(text: 'Mock'),
            Tab(text: 'Quiz'),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[50]!, Colors.indigo[100]!],
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: const [
            QuizChallengeTab(),
            QuizMockTab(),
            AdminQuizTab(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
