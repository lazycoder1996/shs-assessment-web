import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../data/models/question_preamble.dart';

class QuestionPreambleCard extends StatelessWidget {
  final PreambleContent preamble;

  const QuestionPreambleCard({super.key, required this.preamble});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (preamble.title != null) ...[
            Text(
              preamble.title!,
              style: AppTextStyles.title.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 14),
          ],

          Text(
            preamble.content,
            style: AppTextStyles.body.copyWith(height: 1.6, fontSize: 22),
          ),

          if (preamble.imageUrl != null) ...[
            const SizedBox(height: 20),

            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                preamble.imageUrl!,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
