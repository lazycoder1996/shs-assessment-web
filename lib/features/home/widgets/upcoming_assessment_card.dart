import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../assessment/data/models/assessment.dart';
import 'assessment_countdown.dart';

class UpcomingAssessmentCard extends StatelessWidget {
  final Assessment assessment;
  final VoidCallback? onTap;

  const UpcomingAssessmentCard({
    super.key,
    required this.assessment,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final durationMinutes = (assessment.durationSeconds / 60).round();

    final timeUntilStart = assessment.availableFrom.difference(DateTime.now());

    final showCountdown =
        timeUntilStart > Duration.zero &&
        timeUntilStart <= const Duration(hours: 1);

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
            // Top row
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
                    Icons.assignment_rounded,
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
                    'UPCOMING',
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

            const SizedBox(height: 16),

            // --------------------------------------------------
            // Assessment details
            // --------------------------------------------------
            Row(
              children: [
                _InfoItem(
                  icon: Icons.schedule_outlined,
                  text: '$durationMinutes min',
                ),

                const SizedBox(width: 18),

                _InfoItem(
                  icon: Icons.calendar_today_outlined,
                  text: AssessmentDateFormatter.format(
                    assessment.availableFrom,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // --------------------------------------------------
            // Countdown / action
            // --------------------------------------------------
            if (showCountdown)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: AssessmentCountdown(
                  label: 'Starts in',
                  target: assessment.availableFrom,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Scheduled assessment',
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

// ============================================================
// Info item
// ============================================================

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 17, color: AppColors.darkTextTertiary),

        const SizedBox(width: 6),

        Text(text, style: AppTextStyles.caption),
      ],
    );
  }
}

// ============================================================
// Date formatter
// ============================================================

abstract final class AssessmentDateFormatter {
  static String format(DateTime dateTime) {
    final hour =
        dateTime.hour > 12
            ? dateTime.hour - 12
            : dateTime.hour == 0
            ? 12
            : dateTime.hour;

    final minute = dateTime.minute.toString().padLeft(2, '0');

    final period = dateTime.hour >= 12 ? 'PM' : 'AM';

    return '${dateTime.day}/${dateTime.month} · '
        '$hour:$minute $period';
  }
}
