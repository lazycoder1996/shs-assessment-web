import 'package:flutter/material.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/blocks/leaf/paragraph.dart';
import 'package:markdown_widget/widget/markdown.dart';
import 'package:quiz_assessment/features/assessment/data/models/question_content.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import 'answer_option.dart';

class QuestionCard extends StatelessWidget {
  final QuestionContent question;
  final String? selectedOptionId;
  final ValueChanged<String> onOptionSelected;

  const QuestionCard({
    super.key,
    required this.question,
    required this.selectedOptionId,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ${question.questionNumber}',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 14),

          MarkdownWidget(
            data: question.questionText,
            shrinkWrap: true,
            config: MarkdownConfig(
              configs: [
                PConfig(textStyle: const TextStyle(fontSize: 20, height: 1.6)),
              ],
            ),
          ),

          const SizedBox(height: 28),

          ...question.options.map(
            (option) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AnswerOption(
                option: option,
                isSelected: option.id == selectedOptionId,
                onPressed: () {
                  onOptionSelected(option.id);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
