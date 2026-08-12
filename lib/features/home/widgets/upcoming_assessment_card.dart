import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../assessment/data/models/assessment.dart';
import 'assessment_countdown.dart';

class UpcomingAssessmentCard extends StatelessWidget {
  final Assessment assessment;

  const UpcomingAssessmentCard({super.key, required this.assessment});

  @override
  Widget build(BuildContext context) {
    final durationMinutes = (assessment.durationSeconds / 60).round();

    final timeUntilStart = assessment.availableFrom.difference(DateTime.now());

    final showCountdown =
        timeUntilStart > Duration.zero &&
        timeUntilStart <= const Duration(hours: 1);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.assignment_outlined,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(assessment.subject, style: AppTextStyles.bodyMedium),

                const SizedBox(height: 3),

                Text(assessment.title, style: AppTextStyles.caption),

                const SizedBox(height: 8),

                if (showCountdown)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: AssessmentCountdown(
                      label: 'Starts in',
                      // target: DateTime.now(),
                      target: assessment.availableFrom,
                    ),
                  )
                else
                  Text(
                    AssessmentDateFormatter.format(assessment.availableFrom),
                    style: AppTextStyles.caption,
                  ),

                const SizedBox(height: 4),

                Text('$durationMinutes minutes', style: AppTextStyles.caption),
              ],
            ),
          ),

          const Icon(Icons.chevron_right, color: AppColors.darkTextTertiary),
        ],
      ),
    );
  }
}

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
