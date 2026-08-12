import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

enum AssessmentStatus{
  upcoming,completed,live,
}

class AssessmentStatusBadge extends StatelessWidget {
  final AssessmentStatus status;

  const AssessmentStatusBadge({
    super.key,
    required this.status,
  });

  String get label {
    switch (status) {
      case AssessmentStatus.upcoming:
        return 'UPCOMING';

      case AssessmentStatus.live:
        return 'LIVE';

      case AssessmentStatus.completed:
        return 'COMPLETED';
    }
  }

  Color get color {
    switch (status) {
      case AssessmentStatus.upcoming:
        return AppColors.warning;

      case AssessmentStatus.live:
        return AppColors.success;

      case AssessmentStatus.completed:
        return AppColors.darkTextTertiary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}