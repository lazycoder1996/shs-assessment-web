import 'package:quiz_assessment/features/assessment/data/models/assessment.dart';

import '../../../../core/network/api_client.dart';

class AssessmentApi {
  final ApiClient _client;

  AssessmentApi(this._client);

  Future<List<Assessment>> getAssessments() async {
    final response = await _client.get<List<Assessment>>(
      '/api/assessments',
      fromData: (data) {
        return (data as List<dynamic>)
            .map(
              (item) => Assessment.fromJson(
                item as Map<String, dynamic>,
              ),
            )
            .toList();
      },
    );

    return response.data ?? [];
  }

  Future<Assessment> getAssessment(
    String assessmentId,
  ) async {
    final response = await _client.get<Assessment>(
      '/api/assessments/$assessmentId',
      fromData: (data) {
        return Assessment.fromJson(
          data as Map<String, dynamic>,
        );
      },
    );

    return response.data!;
  }
}