class StudentAnswer {
  final String id;
  final String attemptId;
  final String questionId;
  final String? selectedOptionId;
  final DateTime answeredAt;
  final DateTime updatedAt;

  const StudentAnswer({
    required this.id,
    required this.attemptId,
    required this.questionId,
    required this.selectedOptionId,
    required this.answeredAt,
    required this.updatedAt,
  });

  factory StudentAnswer.fromJson(
    Map<String, dynamic> json,
  ) {
    return StudentAnswer(
      id: json['id'] as String,
      attemptId: json['attemptId'] as String,
      questionId: json['questionId'] as String,
      selectedOptionId:
          json['selectedOptionId'] as String?,
      answeredAt: DateTime.parse(
        json['answeredAt'] as String,
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] as String,
      ),
    );
  }

  bool get isAnswered => true;
}