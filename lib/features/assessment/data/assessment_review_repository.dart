import 'dart:developer';

import 'package:quiz_assessment/core/network/api_client.dart';
import 'package:quiz_assessment/features/assessment/data/models/assessment_review.dart';

class AssessmentReviewRepository {
  final ApiClient apiClient;

  AssessmentReviewRepository({required this.apiClient});

  Future<AssessmentReview> getReview(String attemptId) async {
    final response = await apiClient.get<AssessmentReview>(
      '/api/attempts/$attemptId/review',
      fromData: (data) {
        return AssessmentReview.fromJson(data as Map<String, dynamic>);
      },
    );

    return response.data!;
  }
}
