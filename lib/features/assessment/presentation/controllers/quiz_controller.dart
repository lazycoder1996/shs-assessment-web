import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quiz_assessment/app/routes/app_routes.dart';
import 'package:quiz_assessment/core/network/api_client.dart';
import 'package:quiz_assessment/features/assessment/data/assessment_repository.dart';
import 'package:quiz_assessment/features/assessment/data/models/assessment.dart';
import 'package:quiz_assessment/features/assessment/data/models/assessment_attempt.dart';
import 'package:quiz_assessment/features/assessment/data/models/assessment_content.dart';
import 'package:quiz_assessment/features/assessment/data/models/assessment_result.dart';
import 'package:quiz_assessment/features/assessment/data/models/question_content.dart';
import 'package:quiz_assessment/features/assessment/data/models/question_preamble.dart';
import 'package:quiz_assessment/features/assessment/data/models/student_answer.dart';
import 'package:quiz_assessment/features/assessment/presentation/controllers/assessment_countdown_controller.dart';
import 'package:quiz_assessment/features/assessment/services/assessment_autosave.dart';
import 'package:quiz_assessment/features/assessment/services/assessment_clock_service.dart';
import 'package:quiz_assessment/features/assessment/services/assessment_local_storage.dart';
import 'package:quiz_assessment/features/assessment/services/assessment_service.dart';
import 'package:uuid/uuid.dart';

class QuizController extends GetxController {
  final AssessmentService assessmentService;
  final AssessmentLocalStorage localStorage;
  final AssessmentAutosaveService autosaveService;
  final AssessmentCountdownController countdownController;
  final AssessmentClockService clockService;
  QuizController({
    required this.assessmentService,
    required this.localStorage,
    required this.countdownController,
    required this.autosaveService,
    required this.clockService,
  });

  @override
  void onInit() {
    super.onInit();

    _countdownWorker = ever(countdownController.hasEnded, (ended) {
      if (ended == true) {
        _handleTimeExpired();
      }
    });
  }

  final Rxn<Assessment> assessment = Rxn<Assessment>();

  @override
  void onClose() {
    _countdownWorker?.dispose();
    super.onClose();
  }

  final questions = <QuestionContent>[].obs;

  final answers = <String, StudentAnswer>{}.obs;

  final currentQuestionIndex = 0.obs;

  final isLoading = false.obs;

  final isSubmitting = false.obs;

  final errorMessage = RxnString();

  final Rxn<AssessmentAttempt> attempt = Rxn<AssessmentAttempt>();

  AssessmentContent? content;

  Future<void> confirmSubmission() async {
    final unanswered = totalQuestions - answeredCount;

    final shouldSubmit = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Submit Assessment?'),
        content: Text(
          unanswered > 0
              ? 'You have $unanswered unanswered '
                  'question${unanswered == 1 ? '' : 's'}. '
                  'Are you sure you want to submit?'
              : 'You have answered all questions. '
                  'Are you ready to submit your assessment?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: false);
            },
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Get.back(result: true);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );

    if (shouldSubmit != true) {
      return;
    }

    await submitAssessment();
  }

  QuestionContent? get currentQuestion {
    if (questions.isEmpty) {
      return null;
    }

    return questions[currentQuestionIndex.value];
  }

  int get totalQuestions => questions.length;

  int get answeredCount {
    return answers.values
        .where((answer) => answer.selectedOptionId != null)
        .length;
  }

  double get progress {
    if (totalQuestions == 0) {
      return 0;
    }

    return (currentQuestionIndex.value + 1) / totalQuestions;
  }

  Worker? _countdownWorker;

  Future<void> _handleTimeExpired() async {
    if (isSubmitting.value) {
      return;
    }

    await submitAssessment();
  }

  getAssessment(String id) async {
    assessment.value = await assessmentService.getAssessment(id);
  }

  Future<void> startAssessment(String assessmentId) async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      final loadedAssessment = await assessmentService.getAssessment(
        assessmentId,
      );
      assessment.value = loadedAssessment;

      final startedAttempt = await assessmentService.startAssessment(
        assessmentId,
      );

      attempt.value = startedAttempt;
      countdownController.start(
        startAt: startedAttempt.startedAt,
        endAt: startedAttempt.expiresAt,
      );

      final loadedContent = await assessmentService.getContent(
        startedAttempt.id,
      );

      content = loadedContent;

      _buildQuestionList(loadedContent);

      final savedQuestionIndex = await localStorage.loadCurrentQuestion(
        assessmentId,
      );

      if (savedQuestionIndex != null &&
          savedQuestionIndex >= 0 &&
          savedQuestionIndex < questions.length) {
        currentQuestionIndex.value = savedQuestionIndex;
      } else {
        currentQuestionIndex.value = 0;
      }

      final savedAnswers = await localStorage.loadAnswers(assessmentId);
      answers.assignAll(savedAnswers);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void _buildQuestionList(AssessmentContent content) {
    final result = <QuestionContent>[];

    for (final preamble in content.preambles) {
      result.addAll(preamble.questions);
    }

    result.addAll(content.standaloneQuestions);

    result.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

    questions.assignAll(result);
  }

  Future<void> selectAnswer({
    required String assessmentId,
    required String questionId,
    required String optionId,
  }) async {
    final currentAttempt = attempt.value;

    if (currentAttempt == null) {
      return;
    }

    final now = clockService.now();

    final existingAnswer = answers[questionId];

    final answer = StudentAnswer(
      id: existingAnswer?.id ?? const Uuid().v4(),
      attemptId: currentAttempt.id,
      questionId: questionId,
      selectedOptionId: optionId,
      answeredAt: existingAnswer?.answeredAt ?? now,
      updatedAt: now,
    );

    // 1. Update UI immediately.
    answers[questionId] = answer;
    answers.refresh();

    // 2. Save locally.
    await localStorage.saveAnswer(assessmentId: assessmentId, answer: answer);

    // 3. Queue backend synchronization.
    autosaveService.queueAnswer(assessmentId: assessmentId, answer: answer);
  }

  final Rxn<AssessmentResult> result = Rxn<AssessmentResult>();
  bool get isAttemptActive {
    final currentAttempt = attempt.value;

    if (currentAttempt == null) {
      return false;
    }

    return clockService.isAttemptActive(currentAttempt);
  }

  bool _hasSubmitted = false;
  Future<void> submitAssessment() async {
    if (_hasSubmitted || isSubmitting.value) {
      return;
    }

    final currentAttempt = attempt.value;

    if (currentAttempt == null) {
      errorMessage.value = 'No active assessment attempt.';
      return;
    }

    if (isSubmitting.value) {
      return;
    }

    isSubmitting.value = true;
    errorMessage.value = null;
    _hasSubmitted = true;

    try {
      final submittedResult = await Get.find<AssessmentRepository>().submit(
        currentAttempt.id,
      );

      result.value = submittedResult;

      Get.offNamed(AppRoutes.assessmentResult, arguments: submittedResult);
    } on ApiException catch (e) {
      _hasSubmitted = false;
      errorMessage.value = e.message;
    } catch (_) {
      _hasSubmitted = false;
      errorMessage.value = 'Unable to submit the assessment.';
    } finally {
      isSubmitting.value = false;
    }
  }

  String? selectedOptionFor(String questionId) {
    return answers[questionId]?.selectedOptionId;
  }

  Future<void> nextQuestion() async {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;

      await localStorage.saveCurrentQuestion(
        assessmentId: attempt.value!.assessmentId,
        index: currentQuestionIndex.value,
      );
    }
  }

  Future<void> previousQuestion() async {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;

      await localStorage.saveCurrentQuestion(
        assessmentId: attempt.value!.assessmentId,
        index: currentQuestionIndex.value,
      );
    }
  }

  Future<void> goToQuestion(int index) async {
    if (index >= 0 && index < questions.length) {
      currentQuestionIndex.value = index;

      await localStorage.saveCurrentQuestion(
        assessmentId: attempt.value!.assessmentId,
        index: index,
      );
    }
  }

  PreambleContent? preambleFor(QuestionContent question) {
    if (question.preambleId == null || content == null) {
      return null;
    }

    for (final preamble in content!.preambles) {
      if (preamble.id == question.preambleId) {
        return preamble;
      }
    }

    return null;
  }
}
