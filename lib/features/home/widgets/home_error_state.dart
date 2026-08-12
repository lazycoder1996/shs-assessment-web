import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

class HomeErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const HomeErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.cloud_off_outlined,
              size: 40,
              color: AppColors.darkTextTertiary,
            ),
            const SizedBox(height: 16),
            SelectableText(message),
            const SizedBox(height: 12),
            TextButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}
