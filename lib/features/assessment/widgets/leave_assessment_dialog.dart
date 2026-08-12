import 'package:flutter/material.dart';

class LeaveAssessmentDialog extends StatelessWidget {
  const LeaveAssessmentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Leave assessment?'),
      content: const Text(
        'Your current answers are saved locally. '
        'Are you sure you want to leave this assessment?',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('Stay'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('Leave'),
        ),
      ],
    );
  }
}
