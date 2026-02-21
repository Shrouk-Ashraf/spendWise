import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spendwise/core/theme/app_colors.dart';
import 'package:spendwise/core/theme/app_text_styles.dart';

import '../../data/models/monthly_data.dart';

class IncomeExpensesChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final spots = (List<FlSpot> income, List<FlSpot> expenses) {
      return (
      monthlyChartData.asMap().entries
          .map((e) => FlSpot(e.key.toDouble(), e.value.income))
          .toList(),
      monthlyChartData.asMap().entries
          .map((e) => FlSpot(e.key.toDouble(), e.value.expenses))
          .toList(),
      );
    }([], []);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Income vs Expenses',
            style: AppTextStyles.text17SemiBoldDarkBlue,),
          const Gap(20),
          SizedBox(
            height: 220,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: AppColors.baseWhite,
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        final i = value.toInt();
                        if (i < 0 || i >= monthlyChartData.length) return const SizedBox();
                        return Text(monthlyChartData[i].month,
                            style: AppTextStyles.text11RegularGrey400);
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  // Income line
                  LineChartBarData(
                    spots: spots.$1,
                    isCurved: true,
                    color: AppColors.primary,
                    barWidth: 3,
                    dotData: FlDotData(
                      getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
                        radius: 4,
                        color: AppColors.primary,
                        strokeWidth: 0,
                      ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.primary.withValues(alpha: 0.08),
                    ),
                  ),
                  // Expenses line
                  LineChartBarData(
                    spots: spots.$2,
                    isCurved: true,
                    color: AppColors.heavyRed,
                    barWidth: 3,
                    dotData: FlDotData(
                      getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
                        radius: 4,
                        color: AppColors.heavyRed,
                        strokeWidth: 0,
                      ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.heavyRed.withValues(alpha: 0.08),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(12),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LegendDot(color:  AppColors.primary, label: 'Income'),
              const Gap(20),
              _LegendDot(color: AppColors.heavyRed, label: 'Expenses'),
            ],
          ),
        ],
      ),
    ) ;
  }

}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
      ],
    );
  }
}