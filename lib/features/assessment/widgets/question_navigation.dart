import 'package:flutter/material.dart';

class QuestionNavigation extends StatelessWidget {
  final bool isFirstQuestion;
  final bool isLastQuestion;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onSubmit;
  final bool isSubmitting;
  const QuestionNavigation({
    super.key,
    required this.isFirstQuestion,
    required this.isLastQuestion,
    required this.onPrevious,
    required this.onNext,
    required this.onSubmit,
    required this.isSubmitting,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton.icon(
          onPressed: isFirstQuestion ? null : onPrevious,
          icon: const Icon(Icons.arrow_back),
          label: const Text('Previous'),
        ),

        const Spacer(),

        if (isLastQuestion)
          FilledButton.icon(
            onPressed: isSubmitting ? null : onSubmit,
            icon:
                isSubmitting
                    ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                    : const Icon(Icons.send_outlined),
            label: Text(isSubmitting ? 'Submitting...' : 'Submit Assessment'),
          )
        else
          FilledButton.icon(
            onPressed: onNext,
            icon: const Icon(Icons.arrow_forward),
            iconAlignment: IconAlignment.end,
            label: const Text('Next'),
          ),
      ],
    );
  }
}
