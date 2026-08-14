import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_assessment/app/theme/app_text_styles.dart';
import 'package:quiz_assessment/features/assessment/data/models/assessment_review.dart';

class AssessmentReviewSummary extends StatelessWidget {
  final AssessmentReview review;

  const AssessmentReviewSummary({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.5),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildScore(),

              SizedBox(width: 20.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your score', style: AppTextStyles.bodyMedium),
                    SizedBox(height: 4.h),
                    Text(
                      '${review.score} / ${review.totalMarks}',
                      style: AppTextStyles.headlineSmall.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${review.percentage.toStringAsFixed(1)}%',
                      style: AppTextStyles.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 15.h),

          Divider(height: 1.h),

          SizedBox(height: 15.h),

          Row(
            children: [
              Expanded(
                child: _buildStatistic(
                  icon: Icons.check_circle_outline_rounded,
                  value: review.correctAnswers,
                  label: 'Correct',
                ),
              ),
              Expanded(
                child: _buildStatistic(
                  icon: Icons.cancel_outlined,
                  value: review.wrongAnswers,
                  label: 'Wrong',
                ),
              ),
              Expanded(
                child: _buildStatistic(
                  icon: Icons.remove_circle_outline_rounded,
                  value: review.unanswered,
                  label: 'Unanswered',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScore() {
    return SizedBox(
      width: 50.w,
      height: 50.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 50.w,
            height: 50.w,
            child: CircularProgressIndicator(
              value: review.percentage / 100,
              strokeWidth: 7.w,
              backgroundColor: Colors.grey.withOpacity(0.15),
            ),
          ),
          Text(
            '${review.percentage.round()}%',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistic({
    required IconData icon,
    required int value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, size: 22.sp),
        SizedBox(height: 6.h),
        Text(
          '$value',
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 2.h),
        Text(label, style: AppTextStyles.bodySmall),
      ],
    );
  }
}
