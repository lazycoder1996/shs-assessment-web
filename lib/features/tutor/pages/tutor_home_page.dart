import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quiz_assessment/app/routes/app_routes.dart';
import 'package:quiz_assessment/features/tutor/widgets/tutor_assessment_card.dart';
import 'package:quiz_assessment/features/tutor/widgets/tutor_home_header.dart';

import '../controllers/tutor_home_controller.dart';

class TutorHomePage extends StatefulWidget {
  const TutorHomePage({super.key});

  @override
  State<TutorHomePage> createState() => _TutorHomePageState();
}

class _TutorHomePageState extends State<TutorHomePage> {
  late final TutorHomeController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.find<TutorHomeController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.loadAssessments,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
                sliver: SliverToBoxAdapter(child: TutorHomeHeader()),
              ),

              Obx(() {
                if (controller.isLoading.value &&
                    controller.assessments.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (controller.errorMessage.value != null) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.error_outline_rounded),
                            SizedBox(height: 12.h),
                            Text(
                              controller.errorMessage.value!,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16.h),
                            FilledButton(
                              onPressed: controller.loadAssessments,
                              child: const Text('Try again'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                if (controller.assessments.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: Text('No assessments available.')),
                  );
                }

                return SliverPadding(
                  padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 32.h),
                  sliver: SliverList.separated(
                    itemCount: controller.assessments.length,
                    separatorBuilder: (_, __) => SizedBox(height: 14.h),
                    itemBuilder: (context, index) {
                      final assessment = controller.assessments[index];

                      return TutorAssessmentCard(
                        assessment: assessment,
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.tutorStudentResultsPage(assessment.id),
                            arguments: {
                              'assessmentId': assessment.id,
                              'assessmentTitle': assessment.title,
                            },
                          );
                        },
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
