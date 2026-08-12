class Assessment {
  final String id;
  final String subject;
  final String title;
  final List<String> instructions;
  final int durationSeconds;
  final DateTime availableFrom;
  final DateTime availableUntil;
  final String status;

  const Assessment({
    required this.id,
    required this.subject,
    required this.title,
    required this.instructions,
    required this.durationSeconds,
    required this.availableFrom,
    required this.availableUntil,
    required this.status,
  });

  factory Assessment.fromJson(
    Map<String, dynamic> json,
  ) {
    return Assessment(
      id: json['id'] as String,
      subject: json['subject'] as String,
      title: json['title'] as String,
      instructions: (json['instructions'] as List<dynamic>)
          .map((item) => item as String)
          .toList(),
      durationSeconds: json['durationSeconds'] as int,
      availableFrom: DateTime.parse(
        json['availableFrom'] as String,
      ),
      availableUntil: DateTime.parse(
        json['availableUntil'] as String,
      ),
      status: json['status'] as String,
    );
  }

  bool get isLive => status == 'LIVE';

  bool get isUpcoming => status == 'UPCOMING';

  bool get isClosed => status == 'CLOSED';
}