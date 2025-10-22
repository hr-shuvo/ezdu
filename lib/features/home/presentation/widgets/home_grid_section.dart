import 'package:flutter/material.dart';

class HomeGridSection extends StatelessWidget {
  const HomeGridSection({super.key});

  @override
  Widget build(BuildContext context) {

    final gridItems = [
      HomeGridItem(
        icon: Icons.archive_outlined,
        title: 'Archive',
        route: '/archive',
      ),
      HomeGridItem(
        icon: Icons.local_fire_department,
        title: 'Quick Challenge',
        route: '/quick-challenge',
      ),
      HomeGridItem(
        icon: Icons.quiz,
        title: 'Quiz',
        route: '/daily-quiz',
      ),
      HomeGridItem(
        icon: Icons.forum_outlined,
        title: 'Forum',
        route: '/forum',
      ),
      HomeGridItem(
        icon: Icons.emoji_events,
        title: 'Leaderboard',
        route: '/leaderboard',
      ),
      HomeGridItem(
        icon: Icons.storefront_outlined,
        title: 'Shop',
        route: '/shop',
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
        return _buildHomeButton(context, item.icon, item.title, item.route);
      },
    );
  }

  Widget _buildHomeButton(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: .8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: colorScheme.primary, size: 32),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeButton2(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
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

  HomeGridItem({required this.icon, required this.title, required this.route});
}
