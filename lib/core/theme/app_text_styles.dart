import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendwise/core/theme/app_colors.dart';

/// App text styles.
///
/// Define all text styles used in the app here for consistency.
/// Access via: `AppTextStyles.headlineLarge`
abstract class AppTextStyles {
  static TextStyle text30BoldGray = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.darkBlue,
    height: 1.2,
  );
  static TextStyle text16RegularMediumGray = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.mediumGray,
    height: 1.2,
  );
  static TextStyle text16RegularLightGray = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.lightGray,
    height: 1.2,
  );
  static TextStyle text16MediumWhite =TextStyle(
    color: Colors.white,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );
}
