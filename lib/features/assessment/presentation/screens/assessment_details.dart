import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_assessment/features/assessment/presentation/controllers/quiz_controller.dart';
import 'package:quiz_assessment/features/assessment/services/assessment_clock_service.dart';
import 'package:quiz_assessment/features/home/widgets/assessment_info.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../data/models/assessment.dart';

class AssessmentDetailsPage extends StatefulWidget {
  const AssessmentDetailsPage({super.key});

  @override
  State<AssessmentDetailsPage> createState() => _AssessmentDetailsPageState();
}

class _AssessmentDetailsPageState extends State<AssessmentDetailsPage> {
  final quizController = Get.find<QuizController>();

  @override
  void initState() {
    super.initState();
    quizController.getAssessment(Get.parameters['assessmentId']!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Obx(() {
            final assessment = quizController.assessment.value;
            if (assessment == null) {
              return Center(child: CircularProgressIndicator(strokeWidth: 2));
            }
            return ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Dashboard'),
                    ),

                    const SizedBox(height: 32),

                    Text(
                      assessment.subject,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(assessment.title, style: AppTextStyles.headingLarge),

                    const SizedBox(height: 24),

                    Row(
                      children: [
                        AssessmentInfo(
                          icon: Icons.help_outline,
                          label: '3 Questions',
                        ),
                        const SizedBox(width: 24),
                        AssessmentInfo(
                          icon: Icons.timer_outlined,
                          label: '${assessment.durationSeconds / 60} Minutes',
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    AssessmentInstructions(assessment: assessment),

                    const SizedBox(height: 32),

                    AssessmentAvailability(assessment: assessment),

                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.assessmentPage(assessment.id));
                        },
                        child: const Text('Start Assessment'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class AssessmentInstructions extends StatelessWidget {
  final Assessment assessment;

  const AssessmentInstructions({super.key, required this.assessment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Before you begin', style: AppTextStyles.title),

          const SizedBox(height: 20),

          const InstructionItem(
            icon: Icons.save_outlined,
            text: 'Your answers are saved automatically.',
          ),

          const InstructionItem(
            icon: Icons.timer_outlined,
            text: 'The assessment has a fixed time limit.',
          ),

          const InstructionItem(
            icon: Icons.send_outlined,
            text: 'The assessment will submit automatically when time expires.',
          ),

          const InstructionItem(
            icon: Icons.wifi_outlined,
            text:
                'Make sure you have a stable internet connection before starting.',
          ),
        ],
      ),
    );
  }
}

class InstructionItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const InstructionItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppColors.primary),

          const SizedBox(width: 12),

          Expanded(child: Text(text, style: AppTextStyles.body)),
        ],
      ),
    );
  }
}

class AssessmentAvailability extends StatelessWidget {
  final Assessment assessment;

  const AssessmentAvailability({
    super.key,
    required this.assessment,
  });

  @override
  Widget build(BuildContext context) {
    final clockService =
        Get.find<AssessmentClockService>();

    final now = clockService.now();

    final isAvailable =
        !now.isBefore(assessment.availableFrom) &&
        now.isBefore(assessment.availableUntil);

    final hasEnded =
        !now.isBefore(assessment.availableUntil);

    String title;
    String message;
    IconData icon;

    if (hasEnded) {
      title = 'Assessment ended';
      message =
          'This assessment is no longer available.';
      icon = Icons.lock_outline;
    } else if (!isAvailable) {
      title = 'Not available yet';
      message =
          'This assessment will become available at the scheduled time.';
      icon = Icons.schedule_outlined;
    } else {
      title = 'Assessment is ready';
      message =
          'You can start the assessment now.';
      icon = Icons.check_circle_outline;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(
          alpha: 0.06,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}