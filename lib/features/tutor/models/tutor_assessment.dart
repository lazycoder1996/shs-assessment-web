class TutorAssessment {
  final String id;
  final String title;
  final String subject;
  final DateTime availableFrom;
  final DateTime availableUntil;
  final int durationSeconds;
  final bool isPublished;
  final int studentCount;
  final int submittedCount;

  const TutorAssessment({
    required this.id,
    required this.title,
    required this.subject,
    required this.availableFrom,
    required this.availableUntil,
    required this.durationSeconds,
    required this.isPublished,
    required this.studentCount,
    required this.submittedCount,
  });

  factory TutorAssessment.fromJson(Map<String, dynamic> json) {
    return TutorAssessment(
      id: json['id'] as String,
      title: json['title'] as String,
      subject: json['subject'],
      availableFrom: DateTime.parse(json['availableFrom'] as String),
      availableUntil: DateTime.parse(json['availableUntil'] as String),
      durationSeconds: json['durationSeconds'] as int,
      isPublished: json['isPublished'] as bool,
      studentCount: json['studentCount'] as int,
      submittedCount: json['submittedCount'] as int,
    );
  }
}
