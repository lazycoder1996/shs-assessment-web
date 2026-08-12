import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../data/models/assessment_result.dart';

class AssessmentResultPage extends StatelessWidget {
  const AssessmentResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final result =
        Get.arguments as AssessmentResult;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 800,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    size: 72,
                    color: AppColors.primary,
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Assessment Complete',
                    style: AppTextStyles.headingLarge,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Your assessment has been submitted successfully.',
                    style: AppTextStyles.body,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 40),

                  Text(
                    '${result.percentage.toStringAsFixed(1)}%',
                    style: AppTextStyles.headingLarge.copyWith(
                      color: AppColors.primary,
                      fontSize: 56,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '${result.score} / ${result.totalMarks}',
                    style: AppTextStyles.title,
                  ),

                  const SizedBox(height: 40),

                  Row(
                    children: [
                      Expanded(
                        child: AssessmentResultStat(
                          label: 'Correct',
                          value:
                              '${result.correctAnswers}',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AssessmentResultStat(
                          label: 'Wrong',
                          value:
                              '${result.wrongAnswers}',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AssessmentResultStat(
                          label: 'Unanswered',
                          value:
                              '${result.unanswered}',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: () {
                        Get.offAllNamed(
                          AppRoutes.home,
                        );
                      },
                      child: const Text(
                        'Back to Dashboard',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AssessmentResultStat extends StatelessWidget {
  final String label;
  final String value;

  const AssessmentResultStat({super.key, 
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.headingMedium,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
}