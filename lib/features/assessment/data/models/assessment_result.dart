class AssessmentResult {
  final String id;
  final String attemptId;
  final int totalMarks;
  final int score;
  final double percentage;
  final int correctAnswers;
  final int wrongAnswers;
  final int unanswered;
  final DateTime gradedAt;

  const AssessmentResult({
    required this.id,
    required this.attemptId,
    required this.totalMarks,
    required this.score,
    required this.percentage,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.unanswered,
    required this.gradedAt,
  });

  factory AssessmentResult.fromJson(Map<String, dynamic> json) {
    return AssessmentResult(
      id: json['id'] as String,
      attemptId: json['attemptId'] as String,
      totalMarks: json['totalMarks'] as int,
      score: json['score'] as int,
      percentage: (json['percentage'] as num).toDouble(),
      correctAnswers: json['correctAnswers'] as int,
      wrongAnswers: json['wrongAnswers'] as int,
      unanswered: json['unanswered'] as int,
      gradedAt: DateTime.parse(json['gradedAt'] as String),
    );
  }
}
