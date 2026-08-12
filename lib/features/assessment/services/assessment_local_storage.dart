import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/student_answer.dart';

class AssessmentLocalStorage {
  static const String _answersPrefix = 'assessment_answers_';
  static const String _currentQuestionPrefix =
      'assessment_current_question_';

  Future<void> saveAnswer({
    required String assessmentId,
    required StudentAnswer answer,
  }) async {
    final preferences = await SharedPreferences.getInstance();

    final key = '$_answersPrefix$assessmentId';

    final existing = preferences.getString(key);

    final Map<String, dynamic> answers =
        existing == null ? {} : jsonDecode(existing) as Map<String, dynamic>;

    answers[answer.questionId] = {
      'questionId': answer.questionId,
      'selectedOptionId': answer.selectedOptionId,
      'answeredAt': answer.answeredAt.toIso8601String(),
    };

    await preferences.setString(
      key,
      jsonEncode(answers),
    );
  }

  Future<Map<String, StudentAnswer>> loadAnswers(
    String assessmentId,
  ) async {
    final preferences = await SharedPreferences.getInstance();

    final key = '$_answersPrefix$assessmentId';

    final stored = preferences.getString(key);

    if (stored == null) {
      return {};
    }

    final Map<String, dynamic> data = jsonDecode(stored);

    return data.map(
      (questionId, value) {
        final answer = value as Map<String, dynamic>;

        return MapEntry(
          questionId,
          StudentAnswer(
            questionId: answer['questionId'] as String,
            selectedOptionId: answer['selectedOptionId'] as String?,
            answeredAt: DateTime.parse(
              answer['answeredAt'] as String,
            ),
            id: '',
            attemptId: '',
            updatedAt: DateTime.now(),
          ),
        );
      },
    );
  }

  Future<void> clearAnswers(
    String assessmentId,
  ) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.remove(
      '$_answersPrefix$assessmentId',
    );
  }

  // ---------------------------
  // Current question
  // ---------------------------

  Future<void> saveCurrentQuestion({
    required String assessmentId,
    required int index,
  }) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setInt(
      '$_currentQuestionPrefix$assessmentId',
      index,
    );
  }

  Future<int?> loadCurrentQuestion(
    String assessmentId,
  ) async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getInt(
      '$_currentQuestionPrefix$assessmentId',
    );
  }

  Future<void> clearCurrentQuestion(
    String assessmentId,
  ) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.remove(
      '$_currentQuestionPrefix$assessmentId',
    );
  }
}