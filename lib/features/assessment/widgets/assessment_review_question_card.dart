import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/blocks/leaf/paragraph.dart';
import 'package:markdown_widget/widget/markdown.dart';
import 'package:quiz_assessment/app/theme/app_colors.dart';
import 'package:quiz_assessment/app/theme/app_text_styles.dart';
import 'package:quiz_assessment/features/assessment/data/models/assessment_review.dart';
import 'package:quiz_assessment/features/assessment/widgets/assessment_review_option_card.dart';
import 'package:quiz_assessment/features/assessment/widgets/assessment_review_status_badge.dart';

class AssessmentReviewQuestionCard extends StatelessWidget {
  final AssessmentReviewQuestion question;

  const AssessmentReviewQuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuestionHeader(),

          SizedBox(height: 14.h),
          MarkdownWidget(
            data: question.questionText,
            shrinkWrap: true,
            config: MarkdownConfig(
              configs: [
                PConfig(
                  textStyle: AppTextStyles.bodyLarge.copyWith(
                    // fontWeight: FontWeight.w600,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),

          // Text(
          //   question.questionText,
          //   style: AppTextStyles.bodyLarge.copyWith(
          //     fontWeight: FontWeight.w600,
          //     height: 1.45,
          //   ),
          // ),
          SizedBox(height: 18.h),

          ...question.options.map(
            (option) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: AssessmentReviewOptionCard(option: option),
            ),
          ),

          if (question.isUnanswered) ...[
            SizedBox(height: 4.h),
            _buildUnansweredMessage(),
          ],
        ],
      ),
    );
  }

  Widget _buildQuestionHeader() {
    return Row(
      children: [
        Container(
          width: 20.w,
          height: 20.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withOpacity(0.1),
          ),
          child: Text(
            '${question.questionNumber}',
            style: AppTextStyles.titleSmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),

        SizedBox(width: 10.w),

        Expanded(
          child: Text(
            'Question ${question.questionNumber}',
            style: AppTextStyles.titleSmall.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        AssessmentReviewStatusBadge(question: question),
      ],
    );
  }

  Widget _buildUnansweredMessage() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.grey.withOpacity(0.08),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, size: 18.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'You did not answer this question.',
              style: AppTextStyles.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
