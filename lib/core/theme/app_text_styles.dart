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
  static TextStyle text12RegularGray600 = TextStyle(
    color: Colors.grey[600],
    fontSize: 12,
  );
  static TextStyle text32BoldBlack = TextStyle(
    color: Colors.black87,
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );
  static TextStyle text14RegularPrimaryLight = TextStyle(
    fontSize: 14,
    color: AppColors.primaryLight,
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
  static TextStyle text24BoldWhite = TextStyle(
    color: Colors.white,
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle text13RegularBlack = TextStyle(
    color: Colors.black87,
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );

  static TextStyle text11RegularGrey600 = TextStyle(
    color: Colors.grey[600],
    fontSize: 11,
  );
  static TextStyle text11RegularGrey400 =TextStyle(fontSize: 11, color: AppColors.gray400,);

  static TextStyle text11SemiBoldWhite =TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static TextStyle text18SemiBoldBlack = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static TextStyle text13MediumPrimary = TextStyle(
    fontSize: 13,
    color: AppColors.primary,
    fontWeight: FontWeight.w500,
  );
  static TextStyle text15MediumBlack = TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.black87,
    fontSize: 15,
  );
  static TextStyle text13RegularGrey500 = TextStyle(
    fontSize: 13,
    color: Colors.grey[500],
  );

  static TextStyle text14MediumBlack = TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.black87,
    fontSize: 14,
  );

  static TextStyle text20SemiBoldDarkBlue = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.darkBlue,
  );
  static TextStyle text17SemiBoldDarkBlue = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.darkBlue,
  );

  static TextStyle text14RegularSecondaryColor = TextStyle(
    color: AppColors.secondaryColor,
    fontSize: 14,
  );

  static TextStyle text32BoldWhite =TextStyle(
    color: Colors.white,
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );
  static TextStyle text16RegularSecondary = TextStyle(
    color: AppColors.secondaryColor,
    fontSize: 16,
  );
  static TextStyle text13RegularSecondary = TextStyle(
    color: AppColors.secondaryColor,
    fontSize: 13,
  );
  static TextStyle text18SemiBoldDarkBlue =TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.darkBlue,
  );
  static TextStyle text15MediumPrimary =TextStyle(
    color: AppColors.primary,
    fontWeight: FontWeight.w500,
    fontSize: 15,
  );
  static TextStyle text15SemiBoldDarkBlue =TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.darkBlue,
  );
  static TextStyle text13MediumRedColor =TextStyle(
    color: AppColors.redColor,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );
  static TextStyle text12RegularLightGray =TextStyle(
    color: AppColors.lightGray,
    fontSize: 12,
  );
  static TextStyle text13RegularMediumGray =const TextStyle(
      fontSize: 13,
      color: AppColors.mediumGray,);

  static TextStyle text13SemiBoldDarkBlue = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: AppColors.darkBlue);

  static TextStyle text12RegularGray500 = TextStyle(fontSize: 12, color: AppColors.gray500,);

static TextStyle text22BoldDarkBlue = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.darkBlue,
  );
}
