import 'package:quiz_assessment/features/assessment/data/models/question_preamble.dart';

import 'question_content.dart';

class AssessmentContent {
  final String assessmentId;
  final List<PreambleContent> preambles;
  final List<QuestionContent> standaloneQuestions;

  const AssessmentContent({
    required this.assessmentId,
    required this.preambles,
    required this.standaloneQuestions,
  });

  factory AssessmentContent.fromJson(
    Map<String, dynamic> json,
  ) {
    return AssessmentContent(
      assessmentId: json['assessmentId'] as String,
      preambles: (json['preambles'] as List<dynamic>)
          .map(
            (item) => PreambleContent.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
      standaloneQuestions:
          (json['standaloneQuestions'] as List<dynamic>)
              .map(
                (item) => QuestionContent.fromJson(
                  item as Map<String, dynamic>,
                ),
              )
              .toList(),
    );
  }
}