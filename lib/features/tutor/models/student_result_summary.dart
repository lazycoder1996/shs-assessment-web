import 'package:quiz_assessment/features/assessment/data/models/assessment_result.dart';

class StudentResultSummary {
  final String attemptId;
  final String assessmentId;

  final String studentId;
  final String studentNumber;
  final String firstName;
  final String? middleName;
  final String lastName;

  final String status;
  final DateTime? submittedAt;

  final AssessmentResult? result;

  StudentResultSummary({
    required this.attemptId,
    required this.assessmentId,
    required this.studentId,
    required this.studentNumber,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.status,
    required this.submittedAt,
    required this.result,
  });

  String get fullName {
    return [
      firstName,
      if (middleName != null && middleName!.trim().isNotEmpty) middleName!,
      lastName,
    ].join(' ');
  }

  factory StudentResultSummary.fromJson(Map<String, dynamic> json) {
    return StudentResultSummary(
      attemptId: json['attemptId'],
      assessmentId: json['assessmentId'],
      studentId: json['studentId'],
      studentNumber: json['studentNumber'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      status: json['status'],
      submittedAt:
          json['submittedAt'] != null
              ? DateTime.parse(json['submittedAt'])
              : null,
      result:
          json['result'] != null
              ? AssessmentResult.fromJson(json['result'])
              : null,
    );
  }

  bool get isGraded => result?.gradedAt != null;
}
