import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../assessment/data/models/assessment.dart';

class ExpiredAssessmentCard extends StatelessWidget {
  final Assessment assessment;
  final VoidCallback? onTap;

  const ExpiredAssessmentCard({
    super.key,
    required this.assessment,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final durationMinutes =
        (assessment.durationSeconds / 60).round();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: AppColors.border,
          ),
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
                    color: AppColors.darkTextTertiary.withValues(
                      alpha: 0.10,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.lock_outline_rounded,
                    color: AppColors.darkTextTertiary,
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
                    color: AppColors.darkTextTertiary.withValues(
                      alpha: 0.08,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'EXPIRED',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.darkTextTertiary,
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
                color: AppColors.darkTextTertiary,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              assessment.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.headingMedium.copyWith(
                color: AppColors.darkTextSecondary,
              ),
            ),

            const SizedBox(height: 18),

            // --------------------------------------------------
            // Expired message
            // --------------------------------------------------

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.darkTextTertiary.withValues(
                  alpha: 0.05,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.schedule_outlined,
                    color: AppColors.darkTextTertiary,
                    size: 20,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Assessment expired',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.darkTextSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 3),

                        Text(
                          'The submission period has ended.',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // --------------------------------------------------
            // Assessment details
            // --------------------------------------------------

            Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: AppColors.darkTextTertiary,
                ),

                const SizedBox(width: 6),

                Text(
                  AssessmentDateFormatter.format(
                    assessment.availableUntil,
                  ),
                  style: AppTextStyles.caption,
                ),

                const SizedBox(width: 18),

                const Icon(
                  Icons.schedule_outlined,
                  size: 17,
                  color: AppColors.darkTextTertiary,
                ),

                const SizedBox(width: 6),

                Text(
                  '$durationMinutes min',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// ============================================================
// Date formatter
// ============================================================

abstract final class AssessmentDateFormatter {
  static String format(DateTime dateTime) {
    final hour = dateTime.hour > 12
        ? dateTime.hour - 12
        : dateTime.hour == 0
            ? 12
            : dateTime.hour;

    final minute =
        dateTime.minute.toString().padLeft(2, '0');

    final period =
        dateTime.hour >= 12 ? 'PM' : 'AM';

    return '${dateTime.day}/${dateTime.month} · '
        '$hour:$minute $period';
  }
}