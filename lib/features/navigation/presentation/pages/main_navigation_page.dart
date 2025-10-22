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

  final List<Widget> _pages = [
    const HomePage(),
    const LeaderboardPage(),
    const LeaderboardPage(),
    const LeaderboardPage(),
    const LeaderboardPage(),
  ];

  void _onItemTapped(int index) async {
    if (index == 5) {
      final RenderBox bar = context.findRenderObject() as RenderBox;
      await _showMoreMenu(context);
      return;
    }

    setState(() => _currentIndex = index);
  }

  Future<void> _showMoreMenu(BuildContext context) async {
    final overlay = Overlay.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Background tap dismiss
          Positioned.fill(
            child: GestureDetector(
              onTap: () => entry.remove(),
              behavior: HitTestBehavior.translucent,
            ),
          ),

          // Floating popup just above bottom nav
          Positioned(
            left: 0,
            right: 0,
            bottom: 80, // 👈 Adjust for your BottomNavigationBar height
            child: Material(
              color: Colors.transparent,
              child: Container(
                // padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.zero,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: colorScheme.outlineVariant),
                          top: BorderSide(color: colorScheme.outlineVariant),
                        ),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.person_outline),
                        title: const Text('Profile'),
                        onTap: () {
                          entry.remove();
                          Navigator.pushNamed(context, '/profile');
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: colorScheme.outlineVariant),
                        ),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.history),
                        title: const Text('History'),
                        onTap: () {
                          entry.remove();
                          Navigator.pushNamed(context, '/history');
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: colorScheme.outlineVariant),
                        ),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.archive_outlined),
                        title: const Text('Archive'),
                        onTap: () {
                          entry.remove();
                          Navigator.pushNamed(context, '/archive');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlay.insert(entry);
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
            icon: Icon(Icons.card_giftcard_outlined),
            activeIcon: Icon(Icons.card_giftcard),
            label: 'Quest',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz_outlined),
            activeIcon: Icon(Icons.quiz),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_outlined),
            activeIcon: Icon(Icons.emoji_events),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dynamic_feed_outlined),
            activeIcon: Icon(Icons.dynamic_feed),
            label: 'Feed',
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
