import 'dart:convert';
import 'dart:developer';

import 'package:quiz_assessment/features/assessment/data/models/assessment_review.dart';
import 'package:quiz_assessment/features/tutor/models/student_result_summary.dart';

import '../../../../core/network/api_client.dart';

class TutorResultService {
  final ApiClient apiClient;

  TutorResultService({required this.apiClient});

  Future<List<StudentResultSummary>> getResults({
    required String assessmentId,
    String search = '',
  }) async {
    final response = await apiClient.get<List<StudentResultSummary>>(
      '/api/staff/assessments/$assessmentId/results',
      queryParameters: {if (search.trim().isNotEmpty) 'search': search.trim()},
      fromData: (data) {
        return (data["results"] as List<dynamic>)
            .map((item) => StudentResultSummary.fromJson(item))
            .toList();
      },
    );
    return response.data!;
  }

  Future<AssessmentReview> getAttemptReview({required String attemptId}) async {
    final response = await apiClient.get<AssessmentReview>(
      '/api/staff/attempts/$attemptId/review',
      fromData: (data) {
        return AssessmentReview.fromJson(data as Map<String, dynamic>);
      },
    );

    return response.data!;
  }
}
