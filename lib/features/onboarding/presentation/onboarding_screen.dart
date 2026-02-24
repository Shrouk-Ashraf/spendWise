import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spendwise/config/di/di.dart';
import 'package:spendwise/config/routing/app_routes.dart';
import 'package:spendwise/core/theme/app_colors.dart';
import 'package:spendwise/core/utils/components/default_button.dart';
import 'package:spendwise/features/onboarding/presentation/widgets/feature_item.dart';

import '../../../core/theme/app_text_styles.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const _features = [
    'Track your income and expenses',
    'Set and monitor budgets',
    'Achieve your savings goals',
    'Visualize your financial data',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 96.w,
                  height: 96.h,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.18),
                        blurRadius: 16.r,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 48.sp,
                    color: Colors.white,
                  ),
                ),
                Gap(32),

                Text('spendWise'.tr(), style: AppTextStyles.text30BoldGray),
                Gap(8),
                Text(
                  'yourPersonalFinanceManager'.tr(),
                  style: AppTextStyles.text16RegularLightGray,
                ),
               Gap(32),
                Gap(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _features
                      .map((feature) => FeatureItem(label: feature))
                      .toList(),
                ),

                Gap(32),
                DefaultButton(
                  onPressed: () async {
                    sl<SharedPreferences>().setBool('onboarding_completed', true);
                    context.goNamed(AppRoutes.login);
                  },
                  label: "getStarted".tr(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
