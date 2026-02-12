import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:spendwise/core/theme/app_text_styles.dart';

import '../../../../core/theme/app_colors.dart';

class FeatureItem extends StatelessWidget {
  const FeatureItem({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration:  BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          Gap(8),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.text16RegularMediumGray,
            ),
          ),
        ],
      ),
    );
  }
}