import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_assessment/app/theme/app_text_styles.dart';
import 'package:quiz_assessment/features/assessment/data/models/assessment_review.dart';

class AssessmentReviewStatusBadge extends StatelessWidget {
  final AssessmentReviewQuestion question;

  const AssessmentReviewStatusBadge({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    if (question.isUnanswered) {
      return _buildBadge(icon: Icons.remove_rounded, label: 'Skipped');
    }

    if (question.isCorrect) {
      return _buildBadge(icon: Icons.check_rounded, label: 'Correct');
    }

    return _buildBadge(icon: Icons.close_rounded, label: 'Incorrect');
  }

  Widget _buildBadge({required IconData icon, required String label}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        color: Colors.grey.withOpacity(0.08),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp),
          SizedBox(width: 4.w),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
