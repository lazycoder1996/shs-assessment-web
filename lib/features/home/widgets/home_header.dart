import 'package:flutter/material.dart';

import '../../auth/models/auth_user.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class HomeHeader extends StatelessWidget {
  final AuthUser student;

  const HomeHeader({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good morning, ${student.firstName} 👋',
                style: AppTextStyles.headingMedium,
              ),
              const SizedBox(height: 6),
              Text(
                'Ready for your next assessment?',
                style: AppTextStyles.body,
              ),
            ],
          ),
        ),

        CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          child: Text(
            student.firstName.substring(0, 1).toUpperCase(),
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
