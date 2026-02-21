import 'package:flutter/material.dart';
import 'package:spendwise/core/theme/app_colors.dart';
import 'package:spendwise/core/theme/app_text_styles.dart';

class TimeframeToggle extends StatelessWidget {
  const TimeframeToggle({required this.selected, required this.onChanged});

  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: ['weekly', 'monthly', 'yearly'].map((t) {
          final isActive = selected == t;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(t),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isActive
                      ? [BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2))]
                      : [],
                ),
                child: Text(
                  '${t[0].toUpperCase()}${t.substring(1)}',
                  textAlign: TextAlign.center,
                  style:AppTextStyles.text13RegularGrey500.copyWith(
                    color:  isActive ? Colors.white : AppColors.gray500,
                  )
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}