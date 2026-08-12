import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_assessment/app/controllers/app_controller.dart';
import 'package:quiz_assessment/app/routes/app_routes.dart';
import 'package:quiz_assessment/app/theme/app_colors.dart';
import 'package:quiz_assessment/features/assessment/presentation/controllers/assessment_countdown_controller.dart';
import 'package:quiz_assessment/features/assessment/widgets/leave_assessment_dialog.dart';
import 'package:quiz_assessment/features/assessment/widgets/question_content.dart';
import 'package:quiz_assessment/features/auth/controllers/auth_controller.dart';

import '../controllers/quiz_controller.dart';
import '../../widgets/question_navigation.dart';
import '../../widgets/question_navigator.dart';
import '../../widgets/quiz_header.dart';

class AssessmentPage extends StatefulWidget {
  const AssessmentPage({super.key});

  @override
  State<AssessmentPage> createState() => AssessmentPageState();
}

class AssessmentPageState extends State<AssessmentPage> {
  // late final Assessment assessment;

  final quizController = Get.find<QuizController>();
  final countdownController = Get.find<AssessmentCountdownController>();

  _initialize() async {
    final authController = Get.find<AuthController>();

    while (Get.find<AppController>().isReady.value == false) {
      await Future.delayed(const Duration(milliseconds: 50));
    }

    if (!authController.isAuthenticated) {
      Get.offAllNamed(AppRoutes.login);
      return;
    }

    final assessmentId = Get.parameters['assessmentId'];

    if (assessmentId == null || assessmentId.isEmpty) {
      quizController.errorMessage.value = 'Invalid assessment.';
      return;
    }

    quizController.startAssessment(assessmentId);
  }

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !quizController.isAttemptActive,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }

        if (!quizController.isAttemptActive) {
          return;
        }

        final shouldLeave = await Get.dialog<bool>(
          const LeaveAssessmentDialog(),
        );

        if (shouldLeave == true) {
          Get.back();
        }
      },

      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Obx(() {
              if (quizController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (quizController.errorMessage.value != null) {
                return Center(child: Text(quizController.errorMessage.value!));
              }

              final assessment = quizController.assessment.value;
              if (assessment == null) {
                return const Center(child: Text('Assessment not found.'));
              }

              final question = quizController.currentQuestion;
              if (question == null) {
                return const Center(child: Text('No questions available.'));
              }

              return Column(
                children: [
                  QuizHeader(
                    subject: assessment.subject,
                    title: assessment.title,
                    currentQuestion:
                        quizController.currentQuestionIndex.value + 1,
                    totalQuestions: quizController.totalQuestions,
                    answeredQuestions: quizController.answeredCount,
                    remainingTime: countdownController.formattedRemaining,
                    remainingTimeColor: countdownController.timerColor,
                  ),

                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: QuestionContentWidget(
                          question: question,
                          preamble: quizController.preambleFor(question),
                          selectedOptionId: quizController.selectedOptionFor(
                            question.id,
                          ),
                          onOptionSelected: (optionId) {
                            quizController.selectAnswer(
                              assessmentId: assessment.id,
                              questionId: question.id,
                              optionId: optionId,
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  QuestionNavigation(
                    isFirstQuestion:
                        quizController.currentQuestionIndex.value == 0,
                    isLastQuestion:
                        quizController.currentQuestionIndex.value ==
                        quizController.totalQuestions - 1,
                    onPrevious: quizController.previousQuestion,
                    onNext: quizController.nextQuestion,
                    onSubmit: quizController.confirmSubmission,
                    isSubmitting: quizController.isSubmitting.value,
                  ),

                  QuestionNavigator(
                    questionCount: quizController.totalQuestions,
                    currentIndex: quizController.currentQuestionIndex.value,
                    answeredQuestions:
                        quizController.answers.values
                            .where((answer) => answer.isAnswered)
                            .map(
                              (answer) => quizController.questions.indexWhere(
                                (question) => question.id == answer.questionId,
                              ),
                            )
                            .toSet(),
                    onQuestionSelected: quizController.goToQuestion,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
