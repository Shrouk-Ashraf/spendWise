import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spendwise/core/theme/app_text_styles.dart';
class QuickActionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String label;
  final VoidCallback onTap;

  const QuickActionCard({super.key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
            const Gap(8),
            Text(
              label,
              style: AppTextStyles.text14MediumBlack,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}