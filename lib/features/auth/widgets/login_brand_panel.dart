import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class LoginBrandPanel extends StatelessWidget {
  const LoginBrandPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.all(64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 520,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SHS Assess',
                style: AppTextStyles.headingLarge.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'A simple and focused way to complete your school assessments.',
                style: AppTextStyles.body.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}