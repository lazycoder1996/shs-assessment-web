import 'package:flutter/material.dart';
import 'package:quiz_assessment/features/assessment/data/models/question_option.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class AnswerOption extends StatelessWidget {
  final QuestionOption option;
  final bool isSelected;
  final VoidCallback onPressed;

  const AnswerOption({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 180,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withValues(
                    alpha: 0.07,
                  )
                : AppColors.background,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.border,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(
                  milliseconds: 180,
                ),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? AppColors.primary
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.darkTextTertiary,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        size: 17,
                        color: Colors.white,
                      )
                    : null,
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Text(
                  option.text,
                  style: AppTextStyles.body,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}