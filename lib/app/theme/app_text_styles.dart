import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract final class AppTextStyles {
  static const headingLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.darkTextPrimary,
    height: 1.2,
  );

  static const headingMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.darkTextPrimary,
    height: 1.25,
  );

  static const title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.darkTextPrimary,
  );
  static const titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.darkTextPrimary,
  );
  static const titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.darkTextPrimary,
  );
  static const headlineSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.darkTextPrimary,
  );
  static const labelLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: AppColors.darkTextPrimary,
  );
  static const labelSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.darkTextPrimary,
  );



  static const body = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.darkTextSecondary,
    height: 1.5,
  );
  static const bodyLarge = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.darkTextSecondary,
    height: 1.5,
  );

  static const bodyMedium = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.darkTextPrimary,
    height: 1.5,
  );
  static const bodySmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.darkTextPrimary,
    height: 1.5,
  );

  static const caption = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.darkTextTertiary,
  );
}
