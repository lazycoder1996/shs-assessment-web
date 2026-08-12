class AssessmentAttempt {
  final String id;
  final String assessmentId;
  final DateTime startedAt;
  final DateTime expiresAt;
  final String status;

  const AssessmentAttempt({
    required this.id,
    required this.assessmentId,
    required this.startedAt,
    required this.expiresAt,
    required this.status,
  });

  factory AssessmentAttempt.fromJson(
    Map<String, dynamic> json,
  ) {
    return AssessmentAttempt(
      id: json['id'] as String,
      assessmentId:
          json['assessmentId'] as String,
      startedAt: DateTime.parse(
        json['startedAt'] as String,
      ),
      expiresAt: DateTime.parse(
        json['expiresAt'] as String,
      ),
      status: json['status'] as String,
    );
  }

  Duration get remainingTime {
    final difference =
        expiresAt.difference(DateTime.now());

    if (difference.isNegative) {
      return Duration.zero;
    }

    return difference;
  }

  bool get isActive =>
      status == 'IN_PROGRESS' &&
      remainingTime > Duration.zero;
}