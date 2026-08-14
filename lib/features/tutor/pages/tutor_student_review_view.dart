import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:quiz_assessment/app/theme/app_text_styles.dart';
import 'package:quiz_assessment/features/assessment/widgets/assessment_review_header.dart';
import 'package:quiz_assessment/features/assessment/widgets/assessment_review_question_card.dart';
import 'package:quiz_assessment/features/assessment/widgets/assessment_review_summary.dart';

import '../controllers/tutor_results_controller.dart';

class TutorStudentReviewPage extends StatefulWidget {
  const TutorStudentReviewPage({super.key});

  @override
  State<TutorStudentReviewPage> createState() => _TutorStudentReviewPageState();
}

class _TutorStudentReviewPageState extends State<TutorStudentReviewPage> {
  late final TutorResultsController controller;

  late final String attemptId;

  @override
  void initState() {
    super.initState();

    controller = Get.find<TutorResultsController>();

    attemptId = Get.parameters['attemptId']!;

    controller.loadReview(attemptId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Review', style: AppTextStyles.titleMedium),
      ),
      body: Obx(() {
        if (controller.isLoadingReview.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value != null) {
          return _buildErrorState();
        }

        final review = controller.review.value;

        if (review == null) {
          return const Center(child: Text('No review is available.'));
        }

        return RefreshIndicator(
          onRefresh: () {
            return controller.loadReview(review.attemptId);
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0.h),
                child: AssessmentReviewHeader(review: review),
              ),

              Expanded(
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          SizedBox(height: 15.h),

                          AssessmentReviewSummary(review: review),

                          SizedBox(height: 15.h),

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Question Review',
                                  style: AppTextStyles.titleMedium,
                                ),
                              ),
                              Text(
                                '${review.questions.length} questions',
                                style: AppTextStyles.bodySmall,
                              ),
                            ],
                          ),
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
                            child: AssessmentReviewQuestionCard(
                              question: question,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
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
              'Unable to load student review',
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
              onPressed: () {
                controller.loadReview(attemptId);
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
