import 'package:quiz_assessment/features/assessment/data/models/assessment_attempt.dart';
import 'package:quiz_assessment/features/assessment/data/models/assessment_result.dart';

import '../../../core/network/api_client.dart';
import '../data/models/assessment.dart';
import '../data/models/assessment_content.dart';

class AssessmentService {
  final ApiClient apiClient;

  AssessmentService({required this.apiClient});

  Future<AssessmentAttempt> startAssessment(String assessmentId) async {
    final response = await apiClient.post<AssessmentAttempt>(
      '/api/assessments/$assessmentId/start',
      fromData: (data) {
        return AssessmentAttempt.fromJson(data as Map<String, dynamic>);
      },
    );

    return response.data!;
  }

  Future<List<Assessment>> getAssessments() async {
    final response = await apiClient.get<List<Assessment>>(
      '/api/assessments',
      fromData: (data) {
        final list = data as List<dynamic>;

        return list
            .map((item) => Assessment.fromJson(item as Map<String, dynamic>))
            .toList();
      },
    );

    return response.data ?? [];
  }

  Future<Assessment> getAssessment(String assessmentId) async {
    final response = await apiClient.get<Assessment>(
      '/api/assessments/$assessmentId',
      fromData: (data) {
        return Assessment.fromJson(data as Map<String, dynamic>);
      },
    );

    return response.data!;
  }

  Future<AssessmentContent> getContent(String attemptId) async {
    final response = await apiClient.get<AssessmentContent>(
      '/api/attempts/$attemptId/content',
      fromData: (data) {
        return AssessmentContent.fromJson(data as Map<String, dynamic>);
      },
    );

    return response.data!;
  }




  Future<AssessmentResult> submit(String attemptId) async {
    final response = await apiClient.post<AssessmentResult>(
      '/api/attempts/$attemptId/submit',
      fromData: (data) {
        return AssessmentResult.fromJson(data as Map<String, dynamic>);
      },
    );

    return response.data!;
  }
}
