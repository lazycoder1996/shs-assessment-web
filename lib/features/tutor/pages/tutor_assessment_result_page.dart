import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_assessment/app/routes/app_routes.dart';
import 'package:quiz_assessment/features/tutor/widgets/assessment_results_header.dart';
import 'package:quiz_assessment/features/tutor/widgets/student_result_card.dart';
import 'package:quiz_assessment/features/tutor/widgets/student_result_empty_state.dart';

import '../controllers/tutor_results_controller.dart';

class AssessmentResultsPage extends StatefulWidget {
  const AssessmentResultsPage({super.key});

  @override
  State<AssessmentResultsPage> createState() => _AssessmentResultsPageState();
}

class _AssessmentResultsPageState extends State<AssessmentResultsPage> {
  late final TutorResultsController controller;

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    initialize();
  }

  initialize() async {
    controller = Get.find<TutorResultsController>();
    final assessmentId = Get.parameters['assessmentId']!;

    await controller.loadResults(assessmentId);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              children: [
                AssessmentResultsHeader(
                  title: 'assessment',
                  searchController: searchController,
                  onSearch: controller.search,
                ),

                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value &&
                        controller.results.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (controller.errorMessage.value != null) {
                      return Center(
                        child: Text(controller.errorMessage.value!),
                      );
                    }

                    if (controller.results.isEmpty) {
                      return const Center(child: StudentResultsEmptyState());
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
                      itemCount: controller.results.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final result = controller.results[index];

                        return StudentResultCard(
                          result: result,
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.tutorStudentReviewPage(
                                result.attemptId,
                              ),
                            );
                          },
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
