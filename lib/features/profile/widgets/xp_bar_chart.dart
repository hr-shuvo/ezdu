import 'package:ezdu/features/profile/models/progress.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class XPBarChart extends StatelessWidget {
  const XPBarChart({super.key, required this.data});

  final List<DailyProgress> data;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox();

    final maxXP = data.map((e) => e.xp).reduce((a, b) => a > b ? a : b);

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: BarChart(
        BarChartData(
          maxY: maxXP.toDouble() * 1.2,
          // leave some space for labels
          barGroups: data.asMap().entries.map((entry) {
            final index = entry.key;
            final daily = entry.value;
            final isToday = daily.day == 'Today';

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: daily.xp.toDouble(),
                  width: 32,
                  color: isToday
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColor.withOpacity(0.6),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: maxXP.toDouble(),
                    color: Colors.grey.shade200,
                  ),
                ),
              ],
            );
          }).toList(),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final daily = data[value.toInt()];
                  return Text(
                    daily.day.substring(0, 3),
                    style: const TextStyle(fontSize: 12),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
        ),
        swapAnimationDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}
