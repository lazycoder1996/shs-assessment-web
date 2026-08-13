import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_assessment/app/theme/app_colors.dart';

import '../../services/assessment_clock_service.dart';

class AssessmentCountdownController extends GetxController {
  final AssessmentClockService clockService;

  AssessmentCountdownController({
    required this.clockService,
  });

  final remaining = Duration.zero.obs;
  final hasStarted = false.obs;
  final hasEnded = false.obs;

  Timer? timer;

  bool get isWarning =>
      remaining.value <= const Duration(minutes: 10) &&
      remaining.value > const Duration(minutes: 5);

  bool get isCritical =>
      remaining.value <= const Duration(minutes: 5);

  Color get timerColor {
    final time = remaining.value;

    if (time <= const Duration(minutes: 5)) {
      return Colors.red;
    }

    if (time <= const Duration(minutes: 10)) {
      return Colors.orange;
    }

    return AppColors.primary;
  }

  void start({
    required DateTime startAt,
    required DateTime endAt,
  }) {
    timer?.cancel();

    updateCountdown(
      startAt: startAt,
      endAt: endAt,
    );

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        updateCountdown(
          startAt: startAt,
          endAt: endAt,
        );
      },
    );
  }

  void updateCountdown({
    required DateTime startAt,
    required DateTime endAt,
  }) {
    final now = clockService.now();

    // Assessment has not started yet.
    if (now.isBefore(startAt)) {
      hasStarted.value = false;
      hasEnded.value = false;
      remaining.value = startAt.difference(now);
      return;
    }

    // Assessment has expired.
    if (!now.isBefore(endAt)) {
      hasStarted.value = true;
      hasEnded.value = true;
      remaining.value = Duration.zero;

      timer?.cancel();
      return;
    }

    // Assessment is currently live.
    hasStarted.value = true;
    hasEnded.value = false;
    remaining.value = endAt.difference(now);
  }

  String get formattedRemaining {
    final totalSeconds = remaining.value.inSeconds;

    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}