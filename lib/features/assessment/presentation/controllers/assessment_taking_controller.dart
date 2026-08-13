// import 'dart:async';

// import 'package:get/get.dart';
// import 'package:quiz_assessment/core/network/api_error_handler.dart';
// import 'package:quiz_assessment/features/assessment/data/assessment_repository.dart';
// import 'package:quiz_assessment/features/assessment/data/models/assessment_result.dart';
// import 'package:quiz_assessment/features/assessment/data/models/question_content.dart';

// import '../../data/models/assessment_attempt.dart';
// import '../../data/models/assessment_content.dart';
// import '../../data/models/student_answer.dart';

// class AssessmentTakingController extends GetxController {
//   final AssessmentRepository repository;

//   AssessmentTakingController({required this.repository});

//   final result = Rxn<AssessmentResult>();

//   final isLoadingResult = false.obs;

//   final isSubmitted = false.obs;

//   Future<AssessmentResult?> submitAssessment() async {
//     final currentAttempt = attempt.value;

//     if (currentAttempt == null) {
//       errorMessage.value = 'No active assessment attempt found.';

//       return null;
//     }

//     if (isSubmitting.value) {
//       return null;
//     }

//     try {
//       isSubmitting.value = true;
//       errorMessage.value = null;

//       final assessmentResult = await repository.submit(currentAttempt.id);

//       result.value = assessmentResult;

//       isSubmitted.value = true;

//       _timer?.cancel();

//       return assessmentResult;
//     } catch (e) {
//       errorMessage.value = ApiErrorHandler.message(
//         e,
//         fallback: 'Unable to submit assessment.',
//       );

//       return null;
//     } finally {
//       isSubmitting.value = false;
//     }
//   }

//   Future<AssessmentResult?> loadResult() async {
//     final currentAttempt = attempt.value;

//     if (currentAttempt == null) {
//       errorMessage.value = 'No assessment attempt found.';

//       return null;
//     }

//     try {
//       isLoadingResult.value = true;
//       errorMessage.value = null;

//       final assessmentResult = await repository.getResult(currentAttempt.id);

//       result.value = assessmentResult;

//       return assessmentResult;
//     } catch (e) {
//       errorMessage.value = ApiErrorHandler.message(
//         e,
//         fallback: 'Unable to start assessment result.',
//       );
//       return null;
//     } finally {
//       isLoadingResult.value = false;
//     }
//   }

//   // ------------------------------------------------------------
//   // Assessment attempt
//   // ------------------------------------------------------------

//   final attempt = Rxn<AssessmentAttempt>();

//   final content = Rxn<AssessmentContent>();

//   // ------------------------------------------------------------
//   // Loading states
//   // ------------------------------------------------------------

//   final isStarting = false.obs;

//   final isLoadingContent = false.obs;

//   final isLoadingAnswers = false.obs;

//   final isSubmitting = false.obs;

//   // ------------------------------------------------------------
//   // Errors
//   // ------------------------------------------------------------

//   final errorMessage = RxnString();

//   // ------------------------------------------------------------
//   // Questions
//   // ------------------------------------------------------------

//   final currentQuestionIndex = 0.obs;

//   // ------------------------------------------------------------
//   // Answers
//   // ------------------------------------------------------------

//   final answers = <StudentAnswer>[].obs;

//   /// questionId -> selectedOptionId
//   final selectedOptions = <String, String>{}.obs;

//   // ------------------------------------------------------------
//   // Timer
//   // ------------------------------------------------------------

//   final remainingSeconds = 0.obs;

//   Timer? _timer;

//   // ============================================================
//   // LIFECYCLE
//   // ============================================================

//   @override
//   void onClose() {
//     _timer?.cancel();
//     super.onClose();
//   }

//   // ============================================================
//   // START
//   // ============================================================

//   Future<bool> start(String assessmentId) async {
//     try {
//       isStarting.value = true;
//       errorMessage.value = null;

//       final result = await repository.startAssessment(assessmentId);

//       attempt.value = result;

//       _startTimer(result.expiresAt);

//       await loadContent(result.id);

//       await loadAnswers(result.id);

//       return true;
//     } catch (e) {
//       errorMessage.value = ApiErrorHandler.message(
//         e,
//         fallback: 'Unable to start assessment.',
//       );

//       return false;
//     } finally {
//       isStarting.value = false;
//     }
//   }

//   // ============================================================
//   // CONTENT
//   // ============================================================

//   Future<void> loadContent(String attemptId) async {
//     try {
//       isLoadingContent.value = true;
//       errorMessage.value = null;

//       final result = await repository.getContent(attemptId);

//       content.value = result;
//     } catch (e) {
//       errorMessage.value = ApiErrorHandler.message(
//         e,
//         fallback: 'Unable to load assessment content.',
//       );
//     } finally {
//       isLoadingContent.value = false;
//     }
//   }

//   // ============================================================
//   // SAVED ANSWERS
//   // ============================================================

//   Future<void> loadAnswers(String attemptId) async {
//     try {
//       isLoadingAnswers.value = true;

//       final result = await repository.getAnswers(attemptId);

//       answers.assignAll(result);

//       selectedOptions.clear();

//       for (final answer in result) {
//         final optionId = answer.selectedOptionId;

//         if (optionId != null) {
//           selectedOptions[answer.questionId] = optionId;
//         }
//       }
//     } catch (e) {
//       errorMessage.value = ApiErrorHandler.message(
//         e,
//         fallback: 'Unable to load saved answers.',
//       );
//     } finally {
//       isLoadingAnswers.value = false;
//     }
//   }

//   // ============================================================
//   // QUESTION LIST
//   // ============================================================

//   List<QuestionContent> get questions {
//     final assessmentContent = content.value;

//     if (assessmentContent == null) {
//       return [];
//     }

//     final result = <QuestionContent>[];

//     for (final preamble in assessmentContent.preambles) {
//       result.addAll(preamble.questions);
//     }

//     result.addAll(assessmentContent.standaloneQuestions);

//     result.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

//     return result;
//   }

//   QuestionContent? get currentQuestion {
//     final items = questions;

//     if (items.isEmpty) {
//       return null;
//     }

//     if (currentQuestionIndex.value >= items.length) {
//       return null;
//     }

//     return items[currentQuestionIndex.value];
//   }

//   int get totalQuestions {
//     return questions.length;
//   }

//   // ============================================================
//   // NAVIGATION
//   // ============================================================

//   void nextQuestion() {
//     if (currentQuestionIndex.value < totalQuestions - 1) {
//       currentQuestionIndex.value++;
//     }
//   }

//   void previousQuestion() {
//     if (currentQuestionIndex.value > 0) {
//       currentQuestionIndex.value--;
//     }
//   }

//   void goToQuestion(int index) {
//     if (index < 0 || index >= totalQuestions) {
//       return;
//     }

//     currentQuestionIndex.value = index;
//   }

//   bool get isFirstQuestion {
//     return currentQuestionIndex.value == 0;
//   }

//   bool get isLastQuestion {
//     return totalQuestions > 0 &&
//         currentQuestionIndex.value == totalQuestions - 1;
//   }

//   // ============================================================
//   // ANSWERS
//   // ============================================================

//   Future<bool> selectAnswer(String optionId) async {
//     final current = currentQuestion;

//     final currentAttempt = attempt.value;

//     if (current == null || currentAttempt == null) {
//       return false;
//     }

//     final previousOption = selectedOptions[current.id];

//     selectedOptions[current.id] = optionId;

//     try {
//       await repository.saveAnswer(
//         attemptId: currentAttempt.id,
//         questionId: current.id,
//         selectedOptionId: optionId,
//       );

//       return true;
//     } catch (e) {
//       if (previousOption == null) {
//         selectedOptions.remove(current.id);
//       } else {
//         selectedOptions[current.id] = previousOption;
//       }

//       errorMessage.value = ApiErrorHandler.message(
//         e,
//         fallback: 'Unable to save your answer.',
//       );

//       return false;
//     }
//   }

//   String? selectedOptionFor(String questionId) {
//     return selectedOptions[questionId];
//   }

//   bool isAnswered(String questionId) {
//     return selectedOptions.containsKey(questionId);
//   }

//   int get answeredCount {
//     return selectedOptions.length;
//   }

//   int get unansweredCount {
//     return totalQuestions - answeredCount;
//   }

//   // ============================================================
//   // TIMER
//   // ============================================================

//   void _startTimer(DateTime expiresAt) {
//     _timer?.cancel();

//     _updateRemainingTime(expiresAt);

//     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
//       _updateRemainingTime(expiresAt);
//     });
//   }

//   void _updateRemainingTime(DateTime expiresAt) {
//     final now = DateTime.now();

//     final remaining = expiresAt.difference(now);

//     if (remaining.isNegative || remaining.inSeconds <= 0) {
//       remainingSeconds.value = 0;

//       _timer?.cancel();

//       if (!isSubmitting.value && !isSubmitted.value) {
//         submitAssessment();
//       }

//       return;
//     }

//     remainingSeconds.value = remaining.inSeconds;
//   }

//   bool get isTimeRunningOut {
//     return remainingSeconds.value <= 60 && remainingSeconds.value > 0;
//   }

//   bool get hasTimeExpired {
//     return remainingSeconds.value <= 0;
//   }

//   String get formattedRemainingTime {
//     final total = remainingSeconds.value;

//     final minutes = total ~/ 60;

//     final seconds = total % 60;

//     return '${minutes.toString().padLeft(2, '0')}:'
//         '${seconds.toString().padLeft(2, '0')}';
//   }
// }
