import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_assessment/app/theme/app_colors.dart';
import 'package:quiz_assessment/app/theme/app_text_styles.dart';
import 'package:quiz_assessment/features/assessment/data/models/assessment_review.dart';


class AssessmentReviewHeader extends StatelessWidget {
  final AssessmentReview review;

  const AssessmentReviewHeader({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: AppColors.primary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 6.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.r),
              color: Colors.white.withOpacity(0.15),
            ),
            child: Text(
              'COMPLETED',
              style: AppTextStyles.labelSmall.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),

          SizedBox(height: 18.h),

          Text(
            'Assessment Review',
            style: AppTextStyles.headlineSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 6.h),

          Text(
            'Take a look at your answers and see where you can improve.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white.withOpacity(0.85),
            ),
          ),
        ],
      ),
    );
  }
}