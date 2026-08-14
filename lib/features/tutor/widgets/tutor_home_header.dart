import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../auth/controllers/auth_controller.dart';
import '../../../app/theme/app_text_styles.dart';

class TutorHomeHeader extends StatelessWidget {
  TutorHomeHeader({
    super.key,
  });

  final AuthController authController =
      Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final tutor =
        authController.currentStaff.value;

    final firstName =
        tutor?.firstName ?? 'Tutor';

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          'Good afternoon, $firstName 👋',
          style: AppTextStyles.headingMedium,
        ),
        SizedBox(height: 6.h),
        Text(
          'Review your assessments and student results.',
          style: AppTextStyles.body,
        ),
        SizedBox(height: 28.h),
        Text(
          'Your Assessments',
          style: AppTextStyles.titleMedium,
        ),
      ],
    );
  }
}