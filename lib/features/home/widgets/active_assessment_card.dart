import 'package:flutter/material.dart';
import 'package:quiz_assessment/features/home/widgets/assessment_countdown.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../assessment/data/models/assessment.dart';
import 'assessment_info.dart';
import 'assessment_status_badge.dart';

class ActiveAssessmentCard extends StatelessWidget {
  final Assessment assessment;
  final VoidCallback onPressed;

  const ActiveAssessmentCard({
    super.key,
    required this.assessment,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final durationMinutes =
        (assessment.durationSeconds / 60).round();

    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  assessment.subject.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),

              const AssessmentStatusBadge(
                status: AssessmentStatus.live,
              ),
            ],
          ),

          const SizedBox(height: 18),

          Text(
            assessment.title,
            style: AppTextStyles.headingMedium
                .copyWith(
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            'Your assessment is currently live. '
            'You can begin whenever you are ready.',
            style: AppTextStyles.body.copyWith(
              color: Colors.white.withValues(
                alpha: 0.78,
              ),
            ),
          ),

          const SizedBox(height: 24),

          Wrap(
            spacing: 20,
            runSpacing: 10,
            children: [
              AssessmentInfo(
                icon: Icons.timer_outlined,
                label:
                    '$durationMinutes Minutes',
              ),
            ],
          ),

          const SizedBox(height: 22),

          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white.withValues(
                alpha: 0.1,
              ),
              borderRadius:
                  BorderRadius.circular(14),
            ),
            child: AssessmentCountdown(
              label: 'Expires in',
              target:
                  assessment.availableUntil,
              // endAt:
              //     assessment.availableUntil,
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onPressed,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor:
                    AppColors.primary,
                minimumSize:
                    const Size.fromHeight(48),
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'View Assessment',
              ),
            ),
          ),
        ],
      ),
    );
  }
}