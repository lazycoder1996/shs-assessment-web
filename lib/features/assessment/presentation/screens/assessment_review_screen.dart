import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quiz_assessment/app/routes/app_routes.dart';
import 'package:quiz_assessment/app/theme/app_text_styles.dart';
import 'package:quiz_assessment/features/assessment/widgets/assessment_review_header.dart';
import 'package:quiz_assessment/features/assessment/widgets/assessment_review_question_card.dart';
import 'package:quiz_assessment/features/assessment/widgets/assessment_review_summary.dart';
import 'package:quiz_assessment/features/auth/controllers/auth_controller.dart';

import '../controllers/assessment_review_controller.dart';

class AssessmentReviewView extends StatefulWidget {
  const AssessmentReviewView({super.key});

  @override
  State<AssessmentReviewView> createState() => _AssessmentReviewViewState();
}

class _AssessmentReviewViewState extends State<AssessmentReviewView> {
  AssessmentReviewController controller =
      Get.find<AssessmentReviewController>();

  @override
  void initState() {
    super.initState();

    initialize();
  }

  initialize() async {
    final authController = Get.find<AuthController>();

    if (!authController.isAuthenticated) {
      Get.offAllNamed(AppRoutes.login);
      return;
    }

    final attemptId = Get.parameters['attemptId'];
    if (attemptId == null || attemptId.isEmpty) {
      controller.errorMessage.value = 'Invalid assessment.';

      return;
    }
    await controller.loadReview(attemptId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assessment Review', style: AppTextStyles.titleMedium),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value != null) {
          return _buildErrorState();
        }

        final review = controller.review.value;

        if (review == null) {
          return _buildEmptyState();
        }

        return RefreshIndicator(
          onRefresh: () {
            return controller.loadReview(review.attemptId);
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    AssessmentReviewHeader(review: review),

                    SizedBox(height: 15.h),

                    AssessmentReviewSummary(review: review),

                    SizedBox(height: 15.h),

                    _buildQuestionsTitle(review.questions.length),

                    // SizedBox(height: 12.h),
                  ]),
                ),
              ),

              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverList.builder(
                  itemCount: review.questions.length,
                  itemBuilder: (context, index) {
                    final question = review.questions[index];

                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: AssessmentReviewQuestionCard(question: question),
                    );
                  },
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildQuestionsTitle(int questionCount) {
    return Row(
      children: [
        Expanded(
          child: Text('Question Review', style: AppTextStyles.titleMedium),
        ),
        Text('$questionCount questions', style: AppTextStyles.bodySmall),
      ],
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded, size: 48.sp),
            SizedBox(height: 16.h),
            Text(
              'Unable to load review',
              style: AppTextStyles.titleMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              controller.errorMessage.value!,
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            FilledButton.icon(
              onPressed: () async {
                await controller.loadReview(Get.parameters['attemptId']!);
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Text(
          'No assessment review is available.',
          style: AppTextStyles.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
