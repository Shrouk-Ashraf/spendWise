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
  static TextStyle text14RegularLightGray = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.lightGray,
    height: 1.2,
  );
  static TextStyle text14Font500MediumGray = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.mediumGray,
    height: 1.2,
  );
  static TextStyle text14Font500Primary = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    height: 1.2,
  );
  static TextStyle text16NormalGray400 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.gray400,
    height: 1.2,
  );
  static TextStyle text16MediumWhite = TextStyle(
    color: Colors.white,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle text24BoldDarkBlue = TextStyle(
    color: AppColors.darkBlue,
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle text16MediumMediumGray = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.mediumGray,
    height: 1.2,
  );
}
