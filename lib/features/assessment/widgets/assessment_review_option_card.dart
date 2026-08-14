import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_assessment/app/theme/app_text_styles.dart';
import 'package:quiz_assessment/features/assessment/data/models/assessment_review.dart';

class AssessmentReviewOptionCard extends StatelessWidget {
  final AssessmentReviewOption option;

  const AssessmentReviewOptionCard({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    final isCorrect = option.isCorrect;
    final isSelected = option.isSelected;
    final isWrongSelection = isSelected && !isCorrect;

    final backgroundColor = _backgroundColor(
      context,
      isCorrect: isCorrect,
      isWrongSelection: isWrongSelection,
    );

    final borderColor = _borderColor(
      context,
      isCorrect: isCorrect,
      isWrongSelection: isWrongSelection,
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: isCorrect || isWrongSelection ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          _buildOptionLabel(
            context,
            isCorrect: isCorrect,
            isWrongSelection: isWrongSelection,
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Text(
              option.optionText,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight:
                    isSelected || isCorrect ? FontWeight.w600 : FontWeight.w400,
                height: 1.35,
              ),
            ),
          ),

          SizedBox(width: 8.w),

          _buildStatusIcon(
            isCorrect: isCorrect,
            isWrongSelection: isWrongSelection,
          ),
        ],
      ),
    );
  }

  Widget _buildOptionLabel(
    BuildContext context, {
    required bool isCorrect,
    required bool isWrongSelection,
  }) {
    final highlighted = isCorrect || isWrongSelection;

    return Container(
      width: 10.w,
      height: 10.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            highlighted
                ? _highlightColor(
                  isCorrect: isCorrect,
                  isWrongSelection: isWrongSelection,
                )
                : Theme.of(context).dividerColor.withOpacity(0.12),
      ),
      child: Text(
        option.optionLabel,
        style: AppTextStyles.labelSmall.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _buildStatusIcon({
    required bool isCorrect,
    required bool isWrongSelection,
  }) {
    if (isCorrect) {
      return Icon(Icons.check_circle_rounded, size: 22.sp);
    }

    if (isWrongSelection) {
      return Icon(Icons.cancel_rounded, size: 22.sp);
    }

    return const SizedBox.shrink();
  }

  Color _backgroundColor(
    BuildContext context, {
    required bool isCorrect,
    required bool isWrongSelection,
  }) {
    if (isCorrect) {
      return Colors.green.withOpacity(0.08);
    }

    if (isWrongSelection) {
      return Colors.red.withOpacity(0.08);
    }

    return Theme.of(context).cardColor;
  }

  Color _borderColor(
    BuildContext context, {
    required bool isCorrect,
    required bool isWrongSelection,
  }) {
    if (isCorrect) {
      return Colors.green.withOpacity(0.35);
    }

    if (isWrongSelection) {
      return Colors.red.withOpacity(0.35);
    }

    return Theme.of(context).dividerColor.withOpacity(0.5);
  }

  Color _highlightColor({
    required bool isCorrect,
    required bool isWrongSelection,
  }) {
    if (isCorrect) {
      return Colors.green.withOpacity(0.15);
    }

    return Colors.red.withOpacity(0.15);
  }
}
