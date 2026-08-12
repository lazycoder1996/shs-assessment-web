import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

class QuestionNavigator extends StatelessWidget {
  final int questionCount;
  final int currentIndex;
  final Set<int> answeredQuestions;
  final ValueChanged<int> onQuestionSelected;

  const QuestionNavigator({
    super.key,
    required this.questionCount,
    required this.currentIndex,
    required this.answeredQuestions,
    required this.onQuestionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    final crossAxisCount =
        screenWidth >= 1200
            ? 25
            : screenWidth >= 800
            ? 20
            : 15;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 1,
        ),
        itemCount: questionCount,
        itemBuilder: (context, index) {
          final isCurrent = index == currentIndex;
          final isAnswered = answeredQuestions.contains(index);

          final Color backgroundColor;
          final Color borderColor;
          final Color textColor;

          if (isCurrent) {
            backgroundColor = Colors.amber;
            borderColor = Colors.amber.shade700;
            textColor = Colors.white;
          } else if (isAnswered) {
            backgroundColor = Colors.green;
            borderColor = Colors.green.shade700;
            textColor = Colors.white;
          } else {
            backgroundColor = Colors.grey.shade200;
            borderColor = Colors.grey.shade300;
            textColor = Colors.grey.shade600;
          }

          return InkWell(
            onTap: () => onQuestionSelected(index),
            borderRadius: BorderRadius.circular(5),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 140),
              constraints: const BoxConstraints(
                minWidth: 15,
                maxWidth: 15,
                minHeight: 15,
                maxHeight: 15,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: backgroundColor,
                // borderRadius: BorderRadius.circular(5),
                border: Border.all(color: borderColor, width: 0.8),
              ),
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
