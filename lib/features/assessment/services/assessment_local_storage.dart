import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/student_answer.dart';

class AssessmentLocalStorage {
  static const String _answersPrefix = 'assessment_answers_';
  static const String _currentQuestionPrefix =
      'assessment_current_question_';

  Future<void> saveAnswer({
    required String attemptId,
    required StudentAnswer answer,
  }) async {
    final preferences = await SharedPreferences.getInstance();

    final key = '$_answersPrefix$attemptId';

    final existing = preferences.getString(key);

    final Map<String, dynamic> answers =
        existing == null
            ? {}
            : jsonDecode(existing) as Map<String, dynamic>;

    answers[answer.questionId] = {
      'id': answer.id,
      'attemptId': answer.attemptId,
      'questionId': answer.questionId,
      'selectedOptionId': answer.selectedOptionId,
      'answeredAt': answer.answeredAt.toIso8601String(),
      'updatedAt': answer.updatedAt.toIso8601String(),
    };

    await preferences.setString(
      key,
      jsonEncode(answers),
    );
  }

  Future<Map<String, StudentAnswer>> loadAnswers(
    String attemptId,
  ) async {
    final preferences =
        await SharedPreferences.getInstance();

    final key = '$_answersPrefix$attemptId';

    final stored = preferences.getString(key);

    if (stored == null) {
      return {};
    }

    final Map<String, dynamic> data =
        jsonDecode(stored) as Map<String, dynamic>;

    return data.map((questionId, value) {
      final answer =
          value as Map<String, dynamic>;

      return MapEntry(
        questionId,
        StudentAnswer(
          id: answer['id'] as String,
          attemptId: answer['attemptId'] as String,
          questionId: answer['questionId'] as String,
          selectedOptionId:
              answer['selectedOptionId'] as String?,
          answeredAt: DateTime.parse(
            answer['answeredAt'] as String,
          ),
          updatedAt: DateTime.parse(
            answer['updatedAt'] as String,
          ),
        ),
      );
    });
  }

  Future<void> clearAnswers(String attemptId) async {
    final preferences =
        await SharedPreferences.getInstance();

    await preferences.remove(
      '$_answersPrefix$attemptId',
    );
  }

  Future<void> saveCurrentQuestion({
    required String attemptId,
    required int index,
  }) async {
    final preferences =
        await SharedPreferences.getInstance();

    await preferences.setInt(
      '$_currentQuestionPrefix$attemptId',
      index,
    );
  }

  Future<int?> loadCurrentQuestion(
    String attemptId,
  ) async {
    final preferences =
        await SharedPreferences.getInstance();

    return preferences.getInt(
      '$_currentQuestionPrefix$attemptId',
    );
  }

  Future<void> clearCurrentQuestion(
    String attemptId,
  ) async {
    final preferences =
        await SharedPreferences.getInstance();

    await preferences.remove(
      '$_currentQuestionPrefix$attemptId',
    );
  }
}