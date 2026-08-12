import 'package:flutter/material.dart';

import '../../../app/theme/app_text_styles.dart';
import '../../assessment/data/models/assessment.dart';
import 'upcoming_assessment_card.dart';

class UpcomingAssessmentSection extends StatelessWidget {
  final List<Assessment> assessments;

  const UpcomingAssessmentSection({
    super.key,
    required this.assessments,
  });

  @override
  Widget build(BuildContext context) {
    if (assessments.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upcoming assessments',
          style: AppTextStyles.title,
        ),

        const SizedBox(height: 16),

        ...assessments.map(
          (assessment) => Padding(
            padding: const EdgeInsets.only(
              bottom: 12,
            ),
            child: UpcomingAssessmentCard(
              assessment: assessment,
            ),
          ),
        ),
      ],
    );
  }
}