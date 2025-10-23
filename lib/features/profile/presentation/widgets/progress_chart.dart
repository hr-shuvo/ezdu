import 'package:ezdu/features/profile/domain/entities/progress.dart';
import 'package:flutter/material.dart';

class ProgressChart extends StatelessWidget{
  const ProgressChart({super.key, required this.data});

  final List<DailyProgress> data;

  @override
  Widget build(BuildContext context) {
    final maxXP = data.map((e) => e.xp).reduce((a, b) => a > b ? a : b);
    const containerHeight = 200.0;
    const verticalPadding = 16.0 * 2; // top + bottom
    const textHeight = 20.0 + 12.0; // xp text + day text
    final availableBarHeight = containerHeight - verticalPadding - textHeight;

    return Container(
      height: containerHeight,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: data.map((daily) {
          final barHeight = maxXP > 0 ? (daily.xp / maxXP) * availableBarHeight : 0.0;
          final isToday = daily.day == 'Today';

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // XP label on top
              if (daily.xp > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${daily.xp}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),

              // Bar
              Container(
                width: 32,
                height: barHeight,
                decoration: BoxDecoration(
                  color: isToday
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColor.withOpacity(0.6),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Day label
              Text(
                daily.day.substring(0, 3),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  color: isToday ? Theme.of(context).primaryColor : Colors.grey[600],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

}