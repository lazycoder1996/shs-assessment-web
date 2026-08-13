import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../data/api/answer_api.dart';
import '../data/models/student_answer.dart';
import 'assessment_local_storage.dart';

class AssessmentAutosaveService {
  final AnswerApi answerApi;
  final AssessmentLocalStorage localStorage;
  final Connectivity connectivity;

  AssessmentAutosaveService({
    required this.answerApi,
    required this.localStorage,
    Connectivity? connectivity,
  }) : connectivity = connectivity ?? Connectivity();

  Timer? _debounceTimer;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  final Map<String, Map<String, StudentAnswer>> _pendingAnswers = {};

  bool _isSyncing = false;

  // ---------------------------------------------------------
  // INITIALIZATION
  // ---------------------------------------------------------

  void initialize() {
    _connectivitySubscription = connectivity.onConnectivityChanged.listen((
      results,
    ) {
      final hasConnection = results.any(
        (result) => result != ConnectivityResult.none,
      );

      if (hasConnection) {
        syncAll();
      }
    });
  }

  // ---------------------------------------------------------
  // QUEUE ANSWER
  // ---------------------------------------------------------

  void queueAnswer({required String attemptId, required StudentAnswer answer}) {
    final attemptAnswers = _pendingAnswers.putIfAbsent(attemptId, () => {});

    attemptAnswers[answer.questionId] = answer;

    _debounceTimer?.cancel();

    _debounceTimer = Timer(
      const Duration(milliseconds: 500),
      () => sync(attemptId),
    );
  }

  // ---------------------------------------------------------
  // LOAD LOCAL ANSWERS INTO SYNC QUEUE
  // ---------------------------------------------------------

  Future<void> loadPendingAnswers(String attemptId) async {
    final savedAnswers = await localStorage.loadAnswers(attemptId);

    if (savedAnswers.isEmpty) {
      return;
    }

    final pending = _pendingAnswers.putIfAbsent(attemptId, () => {});

    pending.addAll(savedAnswers);
  }

  // ---------------------------------------------------------
  // SYNC ONE ATTEMPT
  // ---------------------------------------------------------
  Future<bool> sync(String attemptId) async {
    if (_isSyncing) {
      return false;
    }

    await loadPendingAnswers(attemptId);

    final attemptAnswers = _pendingAnswers[attemptId];

    if (attemptAnswers == null || attemptAnswers.isEmpty) {
      return true;
    }

    _isSyncing = true;

    try {
      final answersToSync = Map<String, StudentAnswer>.from(attemptAnswers);

      for (final answer in answersToSync.values) {
        final selectedOptionId = answer.selectedOptionId;

        if (selectedOptionId == null) {
          continue;
        }

        await answerApi.saveAnswer(
          attemptId: answer.attemptId,
          questionId: answer.questionId,
          selectedOptionId: selectedOptionId,
        );

        attemptAnswers.remove(answer.questionId);
      }

      if (attemptAnswers.isEmpty) {
        _pendingAnswers.remove(attemptId);
        return true;
      }

      return false;
    } catch (_) {
      return false;
    } finally {
      _isSyncing = false;
    }
  }

  // ---------------------------------------------------------
  // SYNC ALL PENDING ATTEMPTS
  // ---------------------------------------------------------

  Future<void> syncAll() async {
    if (_isSyncing) {
      return;
    }

    final attemptIds = List<String>.from(_pendingAnswers.keys);

    for (final attemptId in attemptIds) {
      await sync(attemptId);
    }
  }

  // ---------------------------------------------------------
  // STATE
  // ---------------------------------------------------------

  bool get hasPendingAnswers => _pendingAnswers.isNotEmpty;

  // ---------------------------------------------------------
  // DISPOSE
  // ---------------------------------------------------------

  void dispose() {
    _debounceTimer?.cancel();
    _connectivitySubscription?.cancel();
  }

  Future<bool> hasPendingAnswersFor(String attemptId) async {
    final localAnswers = await localStorage.loadAnswers(attemptId);

    return localAnswers.isNotEmpty;
  }
}
