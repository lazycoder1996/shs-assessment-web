import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../assessment/data/models/assessment.dart';

class CompletedAssessmentCard extends StatelessWidget {
  final Assessment assessment;
  final double? percentage;
  final VoidCallback? onTap;

  const CompletedAssessmentCard({
    super.key,
    required this.assessment,
    this.percentage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final durationMinutes = (assessment.durationSeconds / 60).round();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --------------------------------------------------
            // Header
            // --------------------------------------------------
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.assignment_turned_in_outlined,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),

                const Spacer(),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'COMPLETED',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // --------------------------------------------------
            // Subject
            // --------------------------------------------------
            Text(
              assessment.subject,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              assessment.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.headingMedium,
            ),

            const SizedBox(height: 18),

            // --------------------------------------------------
            // Result
            // --------------------------------------------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  // Score
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your score', style: AppTextStyles.caption),

                        const SizedBox(height: 4),

                        Text(
                          assessment.formmatedScore ?? '--',
                          style: AppTextStyles.headingMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(width: 1, height: 42, color: AppColors.border),

                  const SizedBox(width: 18),

                  // Duration
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Duration', style: AppTextStyles.caption),

                        const SizedBox(height: 4),

                        Text(
                          '$durationMinutes min',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // --------------------------------------------------
            // Bottom action
            // --------------------------------------------------
            Row(
              children: [
                Expanded(
                  child: Text(
                    'View assessment result',
                    style: AppTextStyles.caption,
                  ),
                ),

                const Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
