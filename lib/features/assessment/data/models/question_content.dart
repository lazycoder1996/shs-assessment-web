import 'question_option.dart';

class QuestionContent {
  final String id;
  final String? preambleId;
  final int questionNumber;
  final String questionText;
  final String type;
  final int marks;
  final int displayOrder;
  final List<QuestionOption> options;

  const QuestionContent({
    required this.id,
    required this.preambleId,
    required this.questionNumber,
    required this.questionText,
    required this.type,
    required this.marks,
    required this.displayOrder,
    required this.options,
  });

  factory QuestionContent.fromJson(
    Map<String, dynamic> json,
  ) {
    return QuestionContent(
      id: json['id'] as String,
      preambleId: json['preambleId'] as String?,
      questionNumber: json['number'] as int,
      questionText: json['text'] as String,
      type: json['type'] as String,
      marks: json['marks'] as int,
      displayOrder: json['displayOrder'] as int,
      options: (json['options'] as List<dynamic>)
          .map(
            (item) => QuestionOption.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
}