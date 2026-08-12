class QuestionOption {
  final String id;
  final String questionId;
  final String label;
  final String text;
  final int displayOrder;

  const QuestionOption({
    required this.id,
    required this.questionId,
    required this.label,
    required this.text,
    required this.displayOrder,
  });

  factory QuestionOption.fromJson(
    Map<String, dynamic> json,
  ) {
    return QuestionOption(
      id: json['id'] as String,
      questionId: json['questionId'] as String,
      label: json['label'] as String,
      text: json['text'] as String,
      displayOrder: json['displayOrder'] as int,
    );
  }
}