import 'package:flutter/material.dart';

class AssessmentCountdownDisplay extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? style;

  const AssessmentCountdownDisplay({
    super.key,
    required this.label,
    required this.value,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.timer_outlined, color: style?.color ?? Colors.white),

        const SizedBox(width: 10),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style:
                  style ?? const TextStyle(color: Colors.white70, fontSize: 12),
            ),

            const SizedBox(height: 2),

            Text(
              value,
              style:
                  style ??
                  const TextStyle(
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
