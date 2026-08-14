import 'package:quiz_assessment/features/assessment/data/api/answer_api.dart';
import 'package:quiz_assessment/features/assessment/data/api/assessment_api.dart';
import 'package:quiz_assessment/features/assessment/data/api/attempt_api.dart';
import 'package:quiz_assessment/features/assessment/data/api/result_api.dart';
import 'package:quiz_assessment/features/assessment/data/models/assessment.dart';
import 'package:quiz_assessment/features/assessment/data/models/assessment_attempt.dart';
import 'package:quiz_assessment/features/assessment/data/models/assessment_content.dart';
import 'package:quiz_assessment/features/assessment/data/models/assessment_result.dart';
import 'package:quiz_assessment/features/assessment/data/models/student_answer.dart';


class AssessmentRepository {
  final AssessmentApi _assessmentApi;
  final AttemptApi _attemptApi;
  final AnswerApi _answerApi;
  final ResultApi _resultApi;

  AssessmentRepository({
    required AssessmentApi assessmentApi,
    required AttemptApi attemptApi,
    required AnswerApi answerApi,
    required ResultApi resultApi,
  })  : _assessmentApi = assessmentApi,
        _attemptApi = attemptApi,
        _answerApi = answerApi,
        _resultApi = resultApi;

  // Assessments

  Future<List<Assessment>> getAssessments() {
    return _assessmentApi.getAssessments();
  }

  Future<Assessment> getAssessment(
    String assessmentId,
  ) {
    return _assessmentApi.getAssessment(
      assessmentId,
    );
  }

  // Attempts

  Future<AssessmentAttempt> startAssessment(
    String assessmentId,
  ) {
    return _attemptApi.startAssessment(
      assessmentId,
    );
  }

  Future<AssessmentContent> getContent(
    String attemptId,
  ) {
    return _attemptApi.getContent(
      attemptId,
    );
  }

  // Answers

  Future<bool> saveAnswer({
    required String attemptId,
    required String questionId,
    required String selectedOptionId,
  }) {
    return _answerApi.saveAnswer(
      attemptId: attemptId,
      questionId: questionId,
      selectedOptionId: selectedOptionId,
    );
  }

  Future<List<StudentAnswer>> getAnswers(
    String attemptId,
  ) {
    return _answerApi.getAnswers(
      attemptId,
    );
  }

  // Results

  Future<AssessmentResult> getResultByAttempt(
    String attemptId,
  ) {
    return _resultApi.getResultByAttempt(
      attemptId,
    );
  }
  Future<AssessmentResult> getResultByAssessment(
    String assessmentId,
  ) {
    return _resultApi.getResultByAssessment(
      assessmentId,
    );
  }
}