import 'package:ezdu/features/leaderboard/presentation/pages/leaderboard_page.dart';
import 'package:flutter/material.dart';

import '../../../home/presentation/pages/home_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [const HomePage(), const LeaderboardPage()];

  void _onItemTapped(int index) async {
    if (index == 5) {
      final RenderBox bar = context.findRenderObject() as RenderBox;
      final Offset position = bar.localToGlobal(Offset.zero);
      await _showMoreMenu(context, position);
      return;
    }

    setState(() => _currentIndex = index);
  }

  Future<void> _showMoreMenu(BuildContext context, Offset position) async {
    final colorScheme = Theme.of(context).colorScheme;

    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final overlaySize = overlay.size;

    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        overlaySize.width -180,
        overlaySize.height - 150,
        16,
        0,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      color: Theme.of(context).cardColor,
      items: [
        PopupMenuItem<String>(
          value: 'profile',
          child: Row(
            children: const [
              Icon(Icons.person_outline, size: 20),
              SizedBox(width: 8),
              Text('Profile'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'history',
          child: Row(
            children: const [
              Icon(Icons.history, size: 20),
              SizedBox(width: 8),
              Text('History'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'archive',
          child: Row(
            children: const [
              Icon(Icons.archive_outlined, size: 20),
              SizedBox(width: 8),
              Text('Archive'),
            ],
          ),
        )
      ],
    );

    if (selected == 'profile') {
      Navigator.pushNamed(context, '/profile');
    } else if (selected == 'history') {
      Navigator.pushNamed(context, '/history');
    } else if (selected == 'archive') {
      Navigator.pushNamed(context, '/archive');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_outlined),
            activeIcon: Icon(Icons.emoji_events),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome_outlined),
            activeIcon: Icon(Icons.auto_awesome),
            label: 'Quest',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz_outlined),
            activeIcon: Icon(Icons.quiz),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.workspace_premium_outlined),
            activeIcon: Icon(Icons.workspace_premium),
            label: 'Premium',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            activeIcon: Icon(Icons.more),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
