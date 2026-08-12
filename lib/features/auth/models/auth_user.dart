class AuthUser {
  final String id;
  final String studentNumber;
  final String firstName;
  final String? middleName;
  final String lastName;

  const AuthUser({
    required this.id,
    required this.studentNumber,
    required this.firstName,
    required this.middleName,
    required this.lastName,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'] as String,
      studentNumber: json['studentNumber'] as String,
      firstName: json['firstName'] as String,
      middleName: json['middleName'] as String?,
      lastName: json['lastName'] as String,
    );
  }

  String get fullName {
    final parts = [
      firstName,
      if (middleName != null && middleName!.trim().isNotEmpty) middleName!,
      lastName,
    ];

    return parts.join(' ');
  }
}
