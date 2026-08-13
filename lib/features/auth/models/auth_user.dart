class AuthUser {
  final String id;
  final String studentNumber;
  final String firstName;
  final String? middleName;
  final String lastName;

  final int? year;
  final String? programmeId;
  final String? programme;
  final int? room;

  const AuthUser({
    required this.id,
    required this.studentNumber,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.year,
    required this.programmeId,
    required this.programme,
    required this.room,
  });

  factory AuthUser.fromJson(
    Map<String, dynamic> json,
  ) {
    return AuthUser(
      id: json['id'] as String,
      studentNumber: json['studentNumber'] as String,
      firstName: json['firstName'] as String,
      middleName: json['middleName'] as String?,
      lastName: json['lastName'] as String,

      year: json['year'] as int?,
      programmeId: json['programmeId'] as String?,
      programme: json['programme'] as String?,
      room: json['room'] as int?,
    );
  }

  String get fullName {
    final parts = [
      firstName,
      if (middleName != null &&
          middleName!.trim().isNotEmpty)
        middleName!,
      lastName,
    ];

    return parts.join(' ');
  }

  String? get classLabel {
    if (year == null ||
        programme == null ||
        room == null) {
      return null;
    }

    return '$year $programme $room';
  }
}