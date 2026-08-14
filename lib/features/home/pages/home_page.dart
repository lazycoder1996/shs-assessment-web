import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_assessment/features/home/widgets/home_assessment_content.dart';
import 'package:quiz_assessment/features/home/widgets/home_error_state.dart';
import 'package:quiz_assessment/features/home/widgets/home_loading_state.dart';
import 'package:quiz_assessment/features/home/widgets/home_navigation_bar.dart';
import 'package:quiz_assessment/features/tutor/pages/tutor_assessment_result_page.dart';
import 'package:quiz_assessment/features/tutor/pages/tutor_home_page.dart';

import '../../../app/routes/app_routes.dart';
import '../../assessment/presentation/controllers/assessment_controller.dart';
import '../../auth/controllers/auth_controller.dart';
import '../widgets/home_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final assessmentController = Get.find<AssessmentController>();

    return Obx(() {
      final isAuthenticated = authController.isAuthenticated;

      if (!isAuthenticated) {
        return Container(color: Colors.red);
      }

      if (authController.isTutor) {
        return TutorHomePage();
      }

      final student = authController.currentUser.value!;
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 28,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeNavigationBar(
                      studentName: student.fullName,
                      onLogout: () {
                        authController.logout();
                        Get.offAllNamed(AppRoutes.login);
                      },
                    ),

                    const SizedBox(height: 42),

                    HomeHeader(student: student),

                    const SizedBox(height: 32),

                    Obx(() {
                      if (assessmentController.isLoading.value) {
                        return const HomeLoadingState();
                      }

                      if (assessmentController.errorMessage.value != null) {
                        return HomeErrorState(
                          message: assessmentController.errorMessage.value!,
                          onRetry: assessmentController.loadAssessments,
                        );
                      }

                      return HomeAssessmentContent(
                        assessmentController: assessmentController,
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
