class AssessmentClockService {
  DateTime now() {
    return DateTime.now();
  }

  Duration timeUntil(DateTime target) {
    return target.difference(now());
  }

  bool hasStarted(DateTime startAt) {
    return !now().isBefore(startAt);
  }

  bool hasEnded(DateTime endAt) {
    return !now().isBefore(endAt);
  }
}