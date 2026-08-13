import 'dart:io';

import 'package:get/get.dart';
import 'package:quiz_assessment/app/controllers/app_controller.dart';
import 'package:quiz_assessment/core/network/api_client.dart';
import 'package:quiz_assessment/features/assessment/data/api/answer_api.dart';
import 'package:quiz_assessment/features/assessment/data/api/assessment_api.dart';
import 'package:quiz_assessment/features/assessment/data/api/attempt_api.dart';
import 'package:quiz_assessment/features/assessment/data/api/result_api.dart';
import 'package:quiz_assessment/features/assessment/data/assessment_repository.dart';
import 'package:quiz_assessment/features/assessment/presentation/controllers/assessment_controller.dart';
import 'package:quiz_assessment/features/assessment/presentation/controllers/assessment_countdown_controller.dart';
import 'package:quiz_assessment/features/assessment/presentation/controllers/quiz_controller.dart';
import 'package:quiz_assessment/features/assessment/services/assessment_autosave.dart';
import 'package:quiz_assessment/features/assessment/services/assessment_clock_service.dart';
import 'package:quiz_assessment/features/assessment/services/assessment_local_storage.dart';
import 'package:quiz_assessment/features/assessment/services/assessment_service.dart';
import 'package:quiz_assessment/features/auth/controllers/auth_controller.dart';
import 'package:quiz_assessment/features/auth/services/auth_service.dart';
import 'package:quiz_assessment/features/auth/services/auth_storage.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ApiClient(baseUrl: 'https://shs-assessment-api.onrender.com'),
    );
    Get.lazyPut<AssessmentClockService>(
      () => AssessmentClockService(),
      fenix: true,
    );
    Get.lazyPut(
      () => AppController(
        authController: Get.find(),
        apiClient: Get.find(),
        clockService: Get.find(),
      ),
    );
    Get.lazyPut(() => AuthService(apiClient: Get.find()));
    Get.lazyPut(() => AuthStorage());
    Get.lazyPut(
      () => AuthController(authService: Get.find(), authStorage: Get.find()),
    );

    Get.lazyPut(() => AssessmentApi(Get.find()));
    Get.lazyPut(() => AttemptApi(Get.find()));
    Get.lazyPut(() => AnswerApi(Get.find()));
    Get.lazyPut(() => ResultApi(Get.find()));
    Get.lazyPut(
      () => AssessmentRepository(
        assessmentApi: Get.find(),
        attemptApi: Get.find(),
        answerApi: Get.find(),
        resultApi: Get.find(),
      ),
    );
    Get.lazyPut(() => AssessmentService(apiClient: Get.find()));
    Get.lazyPut(() => AssessmentController(assessmentService: Get.find()));
    Get.lazyPut(() => AssessmentAutosaveService(answerApi: Get.find()));
    Get.lazyPut(() => AssessmentLocalStorage());
    Get.lazyPut(() => AssessmentCountdownController(clockService: Get.find()));
    Get.lazyPut(
      () => QuizController(
        countdownController: Get.find(),
        autosaveService: Get.find(),
        localStorage: Get.find(),
        assessmentService: Get.find(),
        clockService: Get.find()
      ),
    );
  }
}
