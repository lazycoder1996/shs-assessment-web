import 'package:quiz_assessment/features/assessment/data/models/student_answer.dart';

import '../../../../core/network/api_client.dart';

class AnswerApi {
  final ApiClient _client;

  AnswerApi(this._client);

  Future<bool> saveAnswer({
    required String attemptId,
    required String questionId,
    required String selectedOptionId,
  }) async {
    final response = await _client.post<Map<String, dynamic>>(
      '/api/attempts/$attemptId/answers',
      body: {
        'questionId': questionId,
        'selectedOptionId': selectedOptionId,
      },
      fromData: (data) {
        return data as Map<String, dynamic>;
      },
    );

    return response.data?['saved'] == true;
  }

  Future<List<StudentAnswer>> getAnswers(
    String attemptId,
  ) async {
    final response =
        await _client.get<Map<String, dynamic>>(
      '/api/attempts/$attemptId/answers',
      fromData: (data) {
        return data as Map<String, dynamic>;
      },
    );

    final answers =
        response.data?['answers'] as List<dynamic>? ?? [];

    return answers
        .map(
          (answer) => StudentAnswer.fromJson(
            answer as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}