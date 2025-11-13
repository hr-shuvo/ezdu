import 'package:ezdu/features/feed/pages/feed_page.dart';
import 'package:ezdu/features/home/pages/home_page.dart';
import 'package:ezdu/features/leaderboard/pages/leaderboard_page.dart';
import 'package:ezdu/features/quest/pages/quest_page.dart';
import 'package:ezdu/features/quiz/pages/quiz_tab_page.dart';
import 'package:flutter/material.dart';


class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const QuestPage(),
    const QuizTabPage(),
    const LeaderboardPage(),
    const FeedPage(),
  ];

  void _onItemTapped(int index) async {
    if (index == 5) {
      // final RenderBox bar = context.findRenderObject() as RenderBox;
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Image.asset('assets/icons/house.png', height: 24, width: 24,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard_outlined),
            activeIcon: Image.asset('assets/icons/giftbox.png', height: 24, width: 24,),
            label: 'Quest',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz_outlined),
            activeIcon: Image.asset('assets/icons/reward.png', height: 24, width: 24,),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_outlined),
            activeIcon: Image.asset('assets/icons/award.png', height: 24, width: 24,),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dynamic_feed_outlined),
            activeIcon: Image.asset('assets/icons/chat-balloons.png', height: 24, width: 24,),
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
