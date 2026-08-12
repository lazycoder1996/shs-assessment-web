import 'package:flutter/material.dart';

class AssessmentCountdownDisplay extends StatelessWidget {
  final String label;
  final String value;

  const AssessmentCountdownDisplay({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.timer_outlined,
          color: Colors.white,
        ),

        const SizedBox(width: 10),

        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 2),

            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}