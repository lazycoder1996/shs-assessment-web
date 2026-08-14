import 'package:quiz_assessment/features/assessment/data/models/assessment_result.dart';

import '../../../../core/network/api_client.dart';

class ResultApi {
  final ApiClient _client;

  ResultApi(this._client);

 

  Future<AssessmentResult> getResultByAttempt(
    String attemptId,
  ) async {
    final response =
        await _client.get<AssessmentResult>(
      '/api/attempts/$attemptId/result',
      fromData: (data) {
        return AssessmentResult.fromJson(
          data as Map<String, dynamic>,
        );
      },
    );

    return response.data!;
  }
  Future<AssessmentResult> getResultByAssessment(
    String attemptId,
  ) async {
    final response =
        await _client.get<AssessmentResult>(
      '/api/assessments/$attemptId/result',
      fromData: (data) {
        return AssessmentResult.fromJson(
          data["result"] as Map<String, dynamic>,
        );
      },
    );

    return response.data!;
  }
}