import 'package:quiz_assessment/features/assessment/data/models/assessment_attempt.dart';

class AssessmentClockService {
  Duration _serverOffset = Duration.zero;

  bool _isSynchronized = false;

  bool get isSynchronized => _isSynchronized;

  Duration get serverOffset => _serverOffset;

  void synchronize(DateTime serverTime) {
    _serverOffset =
        serverTime.difference(DateTime.now());

    _isSynchronized = true;
  }

  DateTime now() {
    return DateTime.now().add(_serverOffset);
  }

  Duration timeUntil(DateTime target) {
    final difference = target.difference(now());

    if (difference.isNegative) {
      return Duration.zero;
    }

    return difference;
  }

  bool hasStarted(DateTime startAt) {
    return !now().isBefore(startAt);
  }

  bool hasEnded(DateTime endAt) {
    return !now().isBefore(endAt);
  }

  Duration remainingUntil(DateTime expiresAt) {
    return timeUntil(expiresAt);
  }

  bool isAttemptActive(
    AssessmentAttempt attempt,
  ) {
    return attempt.status == 'IN_PROGRESS' &&
        remainingUntil(attempt.expiresAt) >
            Duration.zero;
  }
}