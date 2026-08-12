import 'dart:async';

import 'package:flutter/material.dart';

import '../../assessment/services/assessment_clock_service.dart';
import 'assessment_countdown_display.dart';

class AssessmentCountdown extends StatefulWidget {
  final DateTime target;
  final String label;
  final VoidCallback? onComplete;

  const AssessmentCountdown({
    super.key,
    required this.target,
    required this.label,
    this.onComplete,
  });

  @override
  State<AssessmentCountdown> createState() => AssessmentCountdownState();
}

class AssessmentCountdownState extends State<AssessmentCountdown> {
  final clockService = AssessmentClockService();

  Timer? timer;

  Duration remaining = Duration.zero;
  bool completed = false;

  @override
  void initState() {
    super.initState();

    updateCountdown();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => updateCountdown(),
    );
  }

  void updateCountdown() {
    final now = clockService.now();

    final difference = widget.target.difference(now);

    if (!mounted) {
      return;
    }

    if (difference <= Duration.zero) {
      setState(() {
        remaining = Duration.zero;
        completed = true;
      });

      timer?.cancel();

      widget.onComplete?.call();

      return;
    }

    setState(() {
      remaining = difference;
      completed = false;
    });
  }

  @override
  void didUpdateWidget(covariant AssessmentCountdown oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.target != widget.target || oldWidget.label != widget.label) {
      timer?.cancel();

      completed = false;

      updateCountdown();

      timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => updateCountdown(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AssessmentCountdownDisplay(
      label: widget.label,
      value: formatDuration(remaining),
    );
  }

  String formatDuration(Duration duration) {
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    if (days > 0) {
      return hours > 0 ? '${days}d ${hours}h' : '${days}d';
    }

    if (hours > 0) {
      return minutes > 0 ? '${hours}h ${minutes}m' : '${hours}h';
    }

    if (minutes > 0) {
      return '${minutes}m '
          '${seconds.toString().padLeft(2, '0')}s';
    }

    return '${seconds}s';
  }
}
