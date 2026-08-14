class StaffUser {
  final String id;
  final String staffNumber;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String email;
  final String role;
  final bool isActive;

  const StaffUser({
    required this.id,
    required this.staffNumber,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.isActive,
  });

  factory StaffUser.fromJson(Map<String, dynamic> json) {
    return StaffUser(
      id: json['id'] as String,
      staffNumber: json['staffNumber'] as String,
      firstName: json['firstName'] as String,
      middleName: json['middleName'] as String?,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      isActive: json['isActive'] as bool,
    );
  }

  String get fullName {
    return [
      firstName,
      if (middleName != null && middleName!.trim().isNotEmpty)
        middleName!,
      lastName,
    ].join(' ');
  }
}