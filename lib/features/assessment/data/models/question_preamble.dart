
import 'question_content.dart';

class PreambleContent {
  final String id;
  final String? title;
  final String content;
  final String? imageUrl;
  final int displayOrder;
  final List<QuestionContent> questions;

  const PreambleContent({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.displayOrder,
    required this.questions,
  });

  factory PreambleContent.fromJson(
    Map<String, dynamic> json,
  ) {
    return PreambleContent(
      id: json['id'] as String,
      title: json['title'] as String?,
      content: json['content'] as String,
      imageUrl: json['imageUrl'] as String?,
      displayOrder: json['displayOrder'] as int,
      questions: (json['questions'] as List<dynamic>)
          .map(
            (item) => QuestionContent.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
}