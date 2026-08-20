import 'package:quiz_assessment/features/auth/models/auth_user.dart';

class AssessmentReview {
  final String attemptId;
  final String assessmentId;
  final int score;
  final int totalMarks;
  final double percentage;
  final int correctAnswers;
  final int wrongAnswers;
  final int unanswered;
  final List<AssessmentReviewQuestion> questions;

  final AuthUser? student;

  const AssessmentReview({
    required this.attemptId,
    required this.assessmentId,
    required this.score,
    required this.totalMarks,
    required this.percentage,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.unanswered,
    required this.questions,
    this.student,
  });

  factory AssessmentReview.fromJson(Map<String, dynamic> json) {
    return AssessmentReview(
      attemptId: json['attemptId'],
      assessmentId: json['assessmentId'],
      student: json['student'] == null? null: AuthUser.fromJson(json["student"]),
      score: json['score'],
      totalMarks: json['totalMarks'],
      percentage: (json['percentage'] as num).toDouble(),
      correctAnswers: json['correctAnswers'],
      wrongAnswers: json['wrongAnswers'],
      unanswered: json['unanswered'],
      questions:
          (json['questions'] as List)
              .map((e) => AssessmentReviewQuestion.fromJson(e))
              .toList(),
    );
  }
}

class AssessmentReviewQuestion {
  final String id;
  final int questionNumber;
  final String questionText;
  final String questionType;
  final int marks;

  final String? selectedOptionId;
  final String? correctOptionId;

  final String? selectedOptionLabel;
  final String? selectedOptionText;

  final String? correctOptionLabel;
  final String? correctOptionText;

  final bool isCorrect;
  final bool isUnanswered;

  final List<AssessmentReviewOption> options;

  const AssessmentReviewQuestion({
    required this.id,
    required this.questionNumber,
    required this.questionText,
    required this.questionType,
    required this.marks,
    this.selectedOptionId,
    this.correctOptionId,
    this.selectedOptionLabel,
    this.selectedOptionText,
    this.correctOptionLabel,
    this.correctOptionText,
    required this.isCorrect,
    required this.isUnanswered,
    required this.options,
  });

  factory AssessmentReviewQuestion.fromJson(Map<String, dynamic> json) {
    return AssessmentReviewQuestion(
      id: json['id'],
      questionNumber: json['questionNumber'],
      questionText: json['questionText'],
      questionType: json['questionType'],
      marks: json['marks'],
      selectedOptionId: json['selectedOptionId'],
      correctOptionId: json['correctOptionId'],
      selectedOptionLabel: json['selectedOptionLabel'],
      selectedOptionText: json['selectedOptionText'],
      correctOptionLabel: json['correctOptionLabel'],
      correctOptionText: json['correctOptionText'],
      isCorrect: json['isCorrect'] ?? false,
      isUnanswered: json['isUnanswered'] ?? false,
      options:
          (json['options'] as List)
              .map((e) => AssessmentReviewOption.fromJson(e))
              .toList(),
    );
  }
}

class AssessmentReviewOption {
  final String id;
  final String optionLabel;
  final String optionText;
  final bool isCorrect;
  final bool isSelected;

  const AssessmentReviewOption({
    required this.id,
    required this.optionLabel,
    required this.optionText,
    required this.isCorrect,
    required this.isSelected,
  });

  factory AssessmentReviewOption.fromJson(Map<String, dynamic> json) {
    return AssessmentReviewOption(
      id: json['id'],
      optionLabel: json['optionLabel'],
      optionText: json['optionText'],
      isCorrect: json['isCorrect'] ?? false,
      isSelected: json['isSelected'] ?? false,
    );
  }
}
