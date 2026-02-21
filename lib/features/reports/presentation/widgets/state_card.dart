import 'package:flutter/material.dart';
import 'package:spendwise/core/theme/app_text_styles.dart';



class StatCard extends StatelessWidget {
  const StatCard({
    required this.label,
    required this.value,
    required this.valueColor,
    required this.subtitle,
  });

  final String label;
  final String value;
  final Color valueColor;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label,
              style: AppTextStyles.text12RegularGray500),
          const SizedBox(height: 4),
          Text(value,
              style: AppTextStyles.text22BoldDarkBlue.copyWith(color: valueColor)),
          const SizedBox(height: 2),
          Text(subtitle,
              style: AppTextStyles.text11RegularGrey400),
        ],
      ),
    );
  }
}