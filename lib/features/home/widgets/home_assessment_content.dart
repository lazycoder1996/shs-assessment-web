import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_assessment/app/routes/app_routes.dart';
import 'package:quiz_assessment/features/assessment/data/models/assessment.dart';
import 'package:quiz_assessment/features/home/widgets/home_empty_state.dart';

import '../../assessment/presentation/controllers/assessment_controller.dart';
import 'active_assessment_card.dart';
import 'upcoming_assessment_section.dart';

class HomeAssessmentContent extends StatelessWidget {
  final AssessmentController assessmentController;

  const HomeAssessmentContent({super.key, required this.assessmentController});

  @override
  Widget build(BuildContext context) {
    final liveAssessments = assessmentController.liveAssessments;

    final upcomingAssessments = assessmentController.upcomingAssessments;

    if (liveAssessments.isEmpty && upcomingAssessments.isEmpty) {
      return const HomeEmptyState();
    }

    final Assessment? featuredAssessment =
        liveAssessments.isNotEmpty ? liveAssessments.first : null;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 850;

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (featuredAssessment != null)
                Expanded(
                  flex: 3,
                  child: ActiveAssessmentCard(
                    assessment: featuredAssessment,
                    onPressed: () {
                      Get.toNamed(
                        AppRoutes.assessmentDetailsPage(featuredAssessment.id),
                      );
                    },
                  ),
                ),

              if (featuredAssessment != null) const SizedBox(width: 24),

              Expanded(
                flex: 2,
                child: UpcomingAssessmentSection(
                  assessments: upcomingAssessments,
                ),
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (featuredAssessment != null)
              ActiveAssessmentCard(
                assessment: featuredAssessment,
                onPressed: () {
                  Get.toNamed(
                    AppRoutes.assessmentDetailsPage(featuredAssessment.id),
                  );
                },
              ),

            if (featuredAssessment != null) const SizedBox(height: 32),

            UpcomingAssessmentSection(assessments: upcomingAssessments),
          ],
        );
      },
    );
  }
}
