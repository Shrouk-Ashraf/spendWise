import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class DashboardHeader extends StatelessWidget {
  final VoidCallback? onMenuTap;
  const DashboardHeader({super.key, this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color:AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
      child: Row(
        children: [
          IconButton(
            onPressed: onMenuTap,
            icon: const Icon(Icons.menu_rounded,
                color: Colors.white, size: 28),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, Alex!',
                style: AppTextStyles.text24BoldWhite,
              ),
              const Gap(8),
              Text(
                'Welcome back to Spend Wise',
                style: AppTextStyles.text14RegularPrimaryLight
              ),
            ],
          ),
        ],
      ),
    );
  }
}
