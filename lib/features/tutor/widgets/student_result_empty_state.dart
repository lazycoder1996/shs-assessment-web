import 'package:flutter/material.dart';

class StudentResultsEmptyState
    extends StatelessWidget {
  const StudentResultsEmptyState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.center,
      children: [
        Icon(
          Icons.assignment_outlined,
          size: 48,
          color: Theme.of(context)
              .colorScheme
              .outline,
        ),

        const SizedBox(height: 16),

        Text(
          'No students found',
          style: Theme.of(context)
              .textTheme
              .titleMedium,
        ),

        const SizedBox(height: 6),

        Text(
          'Try another name or student ID.',
          style: Theme.of(context)
              .textTheme
              .bodyMedium,
        ),
      ],
    );
  }
}