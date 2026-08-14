import 'package:get/get.dart';
import 'package:quiz_assessment/features/assessment/data/api/result_api.dart';
import 'package:quiz_assessment/features/assessment/data/models/assessment_result.dart';

class ResultController extends GetxController {
  final ResultApi resultApi;

  ResultController(this.resultApi);

  Rxn<AssessmentResult> result = Rxn();
  final isLoading = false.obs;
  final errorMessage = RxnString();

  Future<AssessmentResult> getResultsByAssessment(String assessmentId) async {
    return await resultApi.getResultByAssessment(assessmentId);
  }

  Future<AssessmentResult> getResultsByAttempt(String attemptId) async {
    return await resultApi.getResultByAttempt(attemptId);
  }
}
