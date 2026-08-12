import 'dart:async';

import '../data/api/answer_api.dart';
import '../data/models/student_answer.dart';

class AssessmentAutosaveService {
  final AnswerApi answerApi;

  AssessmentAutosaveService({
    required this.answerApi,
  });

  Timer? _debounceTimer;

  final Map<String, Map<String, StudentAnswer>> _pendingAnswers = {};

  void queueAnswer({
    required String assessmentId,
    required StudentAnswer answer,
  }) {
    final assessmentAnswers = _pendingAnswers.putIfAbsent(
      assessmentId,
      () => {},
    );

    assessmentAnswers[answer.questionId] = answer;

    _debounceTimer?.cancel();

    _debounceTimer = Timer(
      const Duration(milliseconds: 500),
      () => sync(assessmentId),
    );
  }

  Future<void> sync(String assessmentId) async {
    final assessmentAnswers = _pendingAnswers[assessmentId];

    if (assessmentAnswers == null ||
        assessmentAnswers.isEmpty) {
      return;
    }

    final answersToSync =
        Map<String, StudentAnswer>.from(
      assessmentAnswers,
    );

    try {
      for (final answer in answersToSync.values) {
        await answerApi.saveAnswer(
          attemptId: answer.attemptId,
          questionId: answer.questionId,
          selectedOptionId:
              answer.selectedOptionId!,
        );
      }

      _pendingAnswers.remove(assessmentId);
    } catch (_) {
      // Keep pending answers for the next sync.
    }
  }

  bool get hasPendingAnswers =>
      _pendingAnswers.isNotEmpty;

  void dispose() {
    _debounceTimer?.cancel();
  }
}