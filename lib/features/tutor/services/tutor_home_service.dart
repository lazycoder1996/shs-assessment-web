import 'package:quiz_assessment/core/network/api_client.dart';

import '../models/tutor_assessment.dart';

class TutorHomeService {
  final ApiClient apiClient;

  TutorHomeService({required this.apiClient});

  Future<List<TutorAssessment>> getAssessments() async {
    final response = await apiClient.get<List<TutorAssessment>>(
      '/api/staff/assessments',
      fromData: (data) {
        return (data as List)
            .map((e) => TutorAssessment.fromJson(e as Map<String, dynamic>))
            .toList();
      },
    );

    return response.data ?? [];
  }
}
