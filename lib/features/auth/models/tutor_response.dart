import 'package:quiz_assessment/features/auth/models/staff_user.dart';

class TutorLoginResponse {
  final StaffUser staff;
  final String token;

  const TutorLoginResponse({
    required this.staff,
    required this.token,
  });

  factory TutorLoginResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return TutorLoginResponse(
      staff: StaffUser.fromJson(
        json['staff'] as Map<String, dynamic>,
      ),
      token: json['token'] as String,
    );
  }
}