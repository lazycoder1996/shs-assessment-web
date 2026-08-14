import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_assessment/features/tutor/models/tutor_assessment.dart';

class TutorAssessmentCard extends StatelessWidget {
  final TutorAssessment assessment;
  final VoidCallback onTap;

  const TutorAssessmentCard({
    super.key,
    required this.assessment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final total = assessment.studentCount;
    final submitted = assessment.submittedCount;

    final progress = total == 0 ? 0.0 : submitted / total;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.all(18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      assessment.title,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, size: 16.sp),
                ],
              ),

              SizedBox(height: 5.h),

              Text(assessment.subject, style: theme.textTheme.bodyMedium),

              SizedBox(height: 18.h),

              Row(
                children: [
                  _StatItem(
                    icon: Icons.people_outline_rounded,
                    label: 'Students',
                    value: '$total',
                  ),

                  SizedBox(width: 24.w),

                  _StatItem(
                    icon: Icons.check_circle_outline_rounded,
                    label: 'Submitted',
                    value: '$submitted',
                  ),
                ],
              ),

              SizedBox(height: 18.h),

              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 7.h,
                      ),
                    ),
                  ),

                  SizedBox(width: 12.w),

                  Text(
                    '${(progress * 100).round()}%',
                    style: theme.textTheme.labelLarge,
                  ),
                ],
              ),

              SizedBox(height: 18.h),

              Row(
                children: [
                  Icon(Icons.timer_outlined, size: 18.sp),
                  SizedBox(width: 6.w),
                  Text(
                    _formatDuration(assessment.durationSeconds),
                    style: theme.textTheme.bodySmall,
                  ),

                  const Spacer(),

                  Text(_statusLabel(), style: theme.textTheme.labelMedium),
                ],
              ),

              SizedBox(height: 16.h),

              SizedBox(
                width: double.infinity,
                child: FilledButton.tonal(
                  onPressed: onTap,
                  child: const Text('View Student Results'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _statusLabel() {
    final now = DateTime.now();

    if (now.isBefore(assessment.availableFrom)) {
      return 'Upcoming';
    }

    if (now.isBefore(assessment.availableUntil)) {
      return 'Live';
    }

    return 'Closed';
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;

    if (minutes < 60) {
      return '$minutes minutes';
    }

    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;

    if (remainingMinutes == 0) {
      return '$hours ${hours == 1 ? 'hour' : 'hours'}';
    }

    return '$hours hr $remainingMinutes min';
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20.sp),
        SizedBox(width: 7.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: theme.textTheme.titleSmall),
            Text(label, style: theme.textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}
