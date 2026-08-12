import 'package:quiz_assessment/features/assessment/data/models/assessment_attempt.dart';
import 'package:quiz_assessment/features/assessment/data/models/assessment_content.dart';

import '../../../../core/network/api_client.dart';

class AttemptApi {
  final ApiClient _client;

  AttemptApi(this._client);

  Future<AssessmentAttempt> startAssessment(
    String assessmentId,
  ) async {
    final response =
        await _client.post<AssessmentAttempt>(
      '/api/assessments/$assessmentId/start',
      fromData: (data) {
        return AssessmentAttempt.fromJson(
          data as Map<String, dynamic>,
        );
      },
    );

    return response.data!;
  }

  Future<AssessmentContent> getContent(
    String attemptId,
  ) async {
    final response =
        await _client.get<AssessmentContent>(
      '/api/attempts/$attemptId/content',
      fromData: (data) {
        return AssessmentContent.fromJson(
          data as Map<String, dynamic>,
        );
      },
    );

    return response.data!;
  }
}