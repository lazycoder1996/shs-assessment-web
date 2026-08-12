import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class HomeNavigationBar extends StatelessWidget {
  final String studentName;
  final VoidCallback onLogout;

  const HomeNavigationBar({
    super.key,
    required this.studentName,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final initial = studentName.isNotEmpty
        ? studentName[0].toUpperCase()
        : '?';

    return Row(
      children: [
        Text(
          'SHS Assess',
          style: AppTextStyles.title.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),

        const Spacer(),

        CircleAvatar(
          radius: 21,
          backgroundColor:
              AppColors.primary.withValues(alpha: 0.1),
          child: Text(
            initial,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        const SizedBox(width: 10),

        if (MediaQuery.sizeOf(context).width >= 600)
          Text(
            studentName,
            style: AppTextStyles.bodyMedium,
          ),

        const SizedBox(width: 8),

        IconButton(
          tooltip: 'Sign out',
          onPressed: onLogout,
          icon: const Icon(
            Icons.logout_outlined,
          ),
        ),
      ],
    );
  }
}