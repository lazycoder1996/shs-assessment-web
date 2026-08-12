import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

class QuizHeader extends StatefulWidget {
  final String subject;
  final String title;
  final int currentQuestion;
  final int totalQuestions;
  final int answeredQuestions;
  final String remainingTime;
  final Color remainingTimeColor;

  const QuizHeader({
    super.key,
    required this.subject,
    required this.title,
    required this.currentQuestion,
    required this.totalQuestions,
    required this.answeredQuestions,
    required this.remainingTime,
    required this.remainingTimeColor,
  });

  @override
  State<StatefulWidget> createState() => _QuizHeaderState();
}

class _QuizHeaderState extends State<QuizHeader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant QuizHeader oldWidget) {
    super.didUpdateWidget(oldWidget);

    final wasCritical = oldWidget.remainingTimeColor == Colors.red;

    final isCritical = widget.remainingTimeColor == Colors.red;

    if (!wasCritical && isCritical) {
      _pulseController.repeat(reverse: true);
    } else if (wasCritical && !isCritical) {
      _pulseController.stop();
      _pulseController.value = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.subject,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                widget.title,
                style: AppTextStyles.caption.copyWith(fontSize: 18),
              ),
            ],
          ),

          const Spacer(),

          Text(
            '${widget.currentQuestion} / ${widget.totalQuestions}',
            style: AppTextStyles.bodyMedium.copyWith(fontSize: 20),
          ),

          const SizedBox(width: 20),

          Text(
            '${widget.answeredQuestions} answered',
            style: AppTextStyles.caption.copyWith(fontSize: 18),
          ),

          const SizedBox(width: 20),
          ScaleTransition(
            scale: _pulseAnimation,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: BoxDecoration(
                color: widget.remainingTimeColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 18,
                    color: widget.remainingTimeColor,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    widget.remainingTime,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: widget.remainingTimeColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
