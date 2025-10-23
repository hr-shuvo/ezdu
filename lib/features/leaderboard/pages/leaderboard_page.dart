import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/features/leaderboard/entities/leaderboard.dart';
import 'package:ezdu/features/leaderboard/widgets/leaderboard_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      // Example: print selected tab index
      print("Selected tab: ${_tabController.index}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Today'),
            Tab(text: 'This Week'),
            Tab(text: 'All Time'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          LeaderboardList(entries: todayEntries),
          LeaderboardList(entries: weeklyEntries),
          LeaderboardList(entries: allTimeEntries),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}


final todayEntries = [
  LeaderboardEntry(
    userId: 1,
    userName: 'Shuvo',
    xp: 120,
    streak: 5,
    imageUrl: null,
  ),
  LeaderboardEntry(
    userId: 2,
    userName: 'Nadia',
    xp: 110,
    streak: 4,
    imageUrl: null,
  ),
  LeaderboardEntry(
    userId: 3,
    userName: 'Rahim',
    xp: 100,
    streak: 3,
    imageUrl: null,
  ),
];

final weeklyEntries = [
  LeaderboardEntry(
    userId: 4,
    userName: 'Sadia',
    xp: 600,
    streak: 10,
    imageUrl: null,
  ),
  LeaderboardEntry(
    userId: 5,
    userName: 'Kamal',
    xp: 580,
    streak: 8,
    imageUrl: null,
  ),
  LeaderboardEntry(
    userId: 6,
    userName: 'Amin',
    xp: 560,
    streak: 9,
    imageUrl: null,
  ),
];

final allTimeEntries = [
  LeaderboardEntry(
    userId: 7,
    userName: 'Bashir',
    xp: 8000,
    streak: 50,
    imageUrl: null,
  ),
  LeaderboardEntry(
    userId: 8,
    userName: 'Tina',
    xp: 7800,
    streak: 48,
    imageUrl: null,
  ),
  LeaderboardEntry(
    userId: 9,
    userName: 'Shuvo',
    xp: 7700,
    streak: 47,
    imageUrl: null,
  ),
  LeaderboardEntry(
    userId: 5,
    userName: 'Kamal',
    xp: 580,
    streak: 8,
    imageUrl: null,
  ),
  LeaderboardEntry(
    userId: 6,
    userName: 'Amin',
    xp: 560,
    streak: 9,
    imageUrl: null,
  ),
];