import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/category_data.dart';

class SpendingPieChart extends StatelessWidget {
  const SpendingPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final total = categoryPieData.fold(0.0, (s, e) => s + e.value);

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
          Text('Spending by Category',
              style: AppTextStyles.text17SemiBoldDarkBlue),
          const Gap(20),
          SizedBox(height: 220, child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              sections: categoryPieData.map((e) {
                final pct = (e.value / total * 100).toStringAsFixed(0);
                return PieChartSectionData(
                  value: e.value,
                  color: e.color,
                  radius: 70,
                  title: '$pct%',
                  titleStyle: AppTextStyles.text11SemiBoldWhite,
                );
              }).toList(),
            ),
          )),
          const Gap(16),
          // Category legend list
          ...categoryPieData.map((e) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12, height: 12,
                      decoration: BoxDecoration(
                        color: e.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(8),
                    Text(e.name,
                      style: AppTextStyles.text13RegularMediumGray,),
                  ],
                ),
                Text('\$${e.value.toStringAsFixed(0)}',
                  style: AppTextStyles.text13SemiBoldDarkBlue,),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
