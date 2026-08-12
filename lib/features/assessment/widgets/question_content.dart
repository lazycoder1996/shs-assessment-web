import 'package:flutter/material.dart';
import 'package:quiz_assessment/features/assessment/data/models/question_content.dart';
import 'package:quiz_assessment/features/assessment/data/models/question_preamble.dart';
import 'package:quiz_assessment/features/assessment/widgets/question_card.dart';
import 'package:quiz_assessment/features/assessment/widgets/question_preamble_card.dart';


class QuestionContentWidget extends StatelessWidget {
  final QuestionContent question;
  final PreambleContent? preamble;
  final String? selectedOptionId;
  final ValueChanged<String> onOptionSelected;

  const QuestionContentWidget({
    super.key,
    required this.question,
    required this.preamble,
    required this.selectedOptionId,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final isDesktop = width >= 900;

    if (preamble == null) {
      return QuestionCard(
        question: question,
        selectedOptionId: selectedOptionId,
        onOptionSelected: onOptionSelected,
      );
    }

    if (isDesktop) {
      return Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Expanded(
            child: QuestionPreambleCard(
              preamble: preamble!,
            ),
          ),

          const SizedBox(width: 24),

          Expanded(
            child: QuestionCard(
              question: question,
              selectedOptionId:
                  selectedOptionId,
              onOptionSelected:
                  onOptionSelected,
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        QuestionPreambleCard(
          preamble: preamble!,
        ),

        const SizedBox(height: 20),

        QuestionCard(
          question: question,
          selectedOptionId: selectedOptionId,
          onOptionSelected: onOptionSelected,
        ),
      ],
    );
  }
}