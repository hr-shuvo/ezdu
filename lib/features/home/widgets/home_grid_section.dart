import 'package:flutter/material.dart';

class HomeGridSection extends StatelessWidget {
  const HomeGridSection({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    final gridItems = [
      HomeGridItem(
        icon: Icons.archive_outlined,
        title: 'Archive',
        route: '/archive',
        color: Colors.purpleAccent,
      ),
      HomeGridItem(
        icon: Icons.local_fire_department,
        title: 'Quick Challenge',
        route: '/quiz',
        color: Colors.orangeAccent,
      ),
      HomeGridItem(
        icon: Icons.quiz,
        title: 'Quiz',
        route: '/quiz',
        color: Colors.greenAccent,
      ),
      HomeGridItem(
        icon: Icons.forum_outlined,
        title: 'Forum',
        route: '/forum',
        color: Colors.cyanAccent,
      ),
      HomeGridItem(
        icon: Icons.emoji_events,
        title: 'Leaderboard',
        route: '/leaderboard',
        color: Colors.amberAccent,
      ),
      HomeGridItem(
        icon: Icons.storefront_outlined,
        title: 'Shop',
        route: '/shop',
        color: Colors.pinkAccent,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: gridItems.length,
      padding: const EdgeInsets.only(top: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.3,
      ),
      itemBuilder: (context, index) {
        final item = gridItems[index];
        return _buildHomeButton(
          context,
          item.icon,
          item.title,
          item.route,
          item.color,
        );
      },
    );
  }

  Widget _buildHomeButton(
    BuildContext context,
    IconData icon,
    String title,
    String route,
    Color color,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final cardBackground = Theme.of(context).brightness == Brightness.dark
        ? color.withValues(alpha: 0.2)
        : color.withValues(alpha: 0.15);

    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: cardBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

}

class HomeGridItem {
  final IconData icon;
  final String title;
  final String route;
  final Color color;

  HomeGridItem({
    required this.icon,
    required this.title,
    required this.route,
    required this.color,
  });
}
