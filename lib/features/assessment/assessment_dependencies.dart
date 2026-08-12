import 'package:quiz_assessment/features/assessment/data/assessment_repository.dart';

import '../../core/network/api_client.dart';
import 'data/api/answer_api.dart';
import 'data/api/assessment_api.dart';
import 'data/api/attempt_api.dart';
import 'data/api/result_api.dart';

class AssessmentDependencies {
  static AssessmentRepository createRepository(
    ApiClient apiClient,
  ) {
    final assessmentApi = AssessmentApi(
      apiClient,
    );

    final attemptApi = AttemptApi(
      apiClient,
    );

    final answerApi = AnswerApi(
      apiClient,
    );

    final resultApi = ResultApi(
      apiClient,
    );

    return AssessmentRepository(
      assessmentApi: assessmentApi,
      attemptApi: attemptApi,
      answerApi: answerApi,
      resultApi: resultApi,
    );
  }
}