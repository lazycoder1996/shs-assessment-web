import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quiz_assessment/features/assessment/presentation/controllers/assessment_controller.dart';
import 'package:quiz_assessment/features/assessment/presentation/controllers/quiz_controller.dart';
import 'package:quiz_assessment/features/assessment/presentation/controllers/result_controller.dart';
import 'package:quiz_assessment/features/auth/controllers/auth_controller.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../data/models/assessment_result.dart';

class AssessmentResultPage extends StatefulWidget {
  const AssessmentResultPage({super.key});

  @override
  State<AssessmentResultPage> createState() => _AssessmentResultPageState();
}

class _AssessmentResultPageState extends State<AssessmentResultPage> {
  final ResultController resultController = Get.find<ResultController>();

  @override
  void initState() {
    super.initState();

    initialize();
  }

  String? assessmentId;
  initialize() async {
    final authController = Get.find<AuthController>();

    if (!authController.isAuthenticated) {
      Get.offAllNamed(AppRoutes.login);
      return;
    }

    assessmentId = Get.parameters['assessmentId'];

    if (assessmentId == null || assessmentId!.isEmpty) {
      resultController.errorMessage.value = 'Invalid assessment.';
      return;
    }
    res.value = await resultController.getResultsByAssessment(assessmentId!);
  }

  Rxn<AssessmentResult> res = Rxn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (resultController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (resultController.errorMessage.value != null) {
            return Center(child: Text(resultController.errorMessage.value!));
          }
          final result = res.value;
          if (result == null) {
            return const Center(child: Text('Assessment not found.'));
          }

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            value: '${result.correctAnswers}',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: AssessmentResultStat(
                            label: 'Wrong',
                            value: '${result.wrongAnswers}',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: AssessmentResultStat(
                            label: 'Unanswered',
                            value: '${result.unanswered}',
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
                          Get.toNamed(AppRoutes.home);
                        },
                        child: const Text('Back to Dashboard'),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: OutlinedButton(
                        onPressed: () {
                          Get.toNamed(
                            AppRoutes.assessmentReviewPage(result.attemptId),
                          );
                        },
                        child: const Text('Review Results'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class AssessmentResultStat extends StatelessWidget {
  final String label;
  final String value;

  const AssessmentResultStat({
    super.key,
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
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Text(value, style: AppTextStyles.headingMedium),
          const SizedBox(height: 6),
          Text(label, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
