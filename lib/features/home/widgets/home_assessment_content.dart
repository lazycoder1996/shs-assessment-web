import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quiz_assessment/app/routes/app_routes.dart';
import 'package:quiz_assessment/app/theme/app_text_styles.dart';
import 'package:quiz_assessment/features/assessment/data/models/assessment.dart';
import 'package:quiz_assessment/features/home/widgets/assessment_title.dart';
import 'package:quiz_assessment/features/home/widgets/completed_assessment_card.dart';
import 'package:quiz_assessment/features/home/widgets/expired_assessment_card.dart';
import 'package:quiz_assessment/features/home/widgets/home_empty_state.dart';
import 'package:quiz_assessment/features/home/widgets/upcoming_assessment_card.dart';

import '../../assessment/presentation/controllers/assessment_controller.dart';
import 'active_assessment_card.dart';
import 'upcoming_assessment_section.dart';

class HomeAssessmentContent extends StatelessWidget {
  final AssessmentController assessmentController;

  const HomeAssessmentContent({super.key, required this.assessmentController});

  @override
  Widget build(BuildContext context) {
    final liveAssessments = assessmentController.liveAssessments;

    final upcomingAssessments = assessmentController.upcomingAssessments;
    final completedAssessments = assessmentController.completedAssessments;
    final expiredAssessments = assessmentController.closedAssessments;

    if (liveAssessments.isEmpty &&
        upcomingAssessments.isEmpty &&
        upcomingAssessments.isEmpty &&
        expiredAssessments.isEmpty) {
      return const HomeEmptyState();
    }

    // final List<Assessment>? featuredAssessment =
    //     liveAssessments.isNotEmpty ? liveAssessments : null;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 850;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (liveAssessments.isNotEmpty) ...[
              AssessmentTitle(title: 'Live Assessments'),
              SizedBox(height: 5.h),
              ...liveAssessments.take(3).map((e) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: ActiveAssessmentCard(
                    assessment: e,
                    expiresAt: e.availableUntil,
                    onTap: () {
                      Get.toNamed(AppRoutes.assessmentDetailsPage(e.id));
                    },
                  ),
                );
              }),
              SizedBox(height: 15.h),
            ],
            if (upcomingAssessments.isNotEmpty) ...[
              AssessmentTitle(title: 'Upcoming Assessments'),
              SizedBox(height: 5.h),
              ...upcomingAssessments.take(3).map((e) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: UpcomingAssessmentCard(
                    assessment: e,
                    // onPressed: () {
                    //   Get.toNamed(AppRoutes.assessmentDetailsPage(e.id));
                    // },
                  ),
                );
              }),
              SizedBox(height: 15.h),
            ],

            if (completedAssessments.isNotEmpty) ...[
              AssessmentTitle(title: 'Completed Assessments'),
              SizedBox(height: 5.h),
              ...completedAssessments.take(3).map((e) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: CompletedAssessmentCard(
                    onTap: () {
                      Get.toNamed(AppRoutes.assessmentResultPage(e.id));
                    },

                    assessment: e,
                    // onPressed: () {
                    //   Get.toNamed(AppRoutes.assessmentDetailsPage(e.id));
                    // },
                  ),
                );
              }),
              SizedBox(height: 15.h),
            ],
            if (expiredAssessments.isNotEmpty) ...[
              AssessmentTitle(title: 'Expired Assessments'),
              SizedBox(height: 5.h),
              ...expiredAssessments.take(3).map((e) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: ExpiredAssessmentCard(
                    assessment: e,
                    // onPressed: () {
                    //   Get.toNamed(AppRoutes.assessmentDetailsPage(e.id));
                    // },
                  ),
                );
              }),
              SizedBox(height: 15.h),
            ],
          ],
        );

        // if (isWide) {
        //   return Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       if (featuredAssessment != null)
        //         Expanded(
        //           flex: 3,
        //           child: ActiveAssessmentCard(
        //             assessment: featuredAssessment,
        //             onPressed: () {
        //               Get.toNamed(
        //                 AppRoutes.assessmentDetailsPage(featuredAssessment.id),
        //               );
        //             },
        //           ),
        //         ),
        //       Expanded(
        //         flex: 3,
        //         child: ActiveAssessmentCard(
        //           assessment: featuredAssessment!,
        //           onPressed: () {
        //             Get.toNamed(
        //               AppRoutes.assessmentDetailsPage(featuredAssessment.id),
        //             );
        //           },
        //         ),
        //       ),

        //       if (featuredAssessment != null) const SizedBox(width: 24),

        //       Expanded(
        //         flex: 2,
        //         child: UpcomingAssessmentSection(
        //           assessments: upcomingAssessments,
        //         ),
        //       ),
        //     ],
        //   );
      },

      //   return Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       if (featuredAssessment != null)
      //         ActiveAssessmentCard(
      //           assessment: featuredAssessment,
      //           onPressed: () {
      //             Get.toNamed(
      //               AppRoutes.assessmentDetailsPage(featuredAssessment.id),
      //             );
      //           },
      //         ),

      //       if (featuredAssessment != null) const SizedBox(height: 32),

      //       UpcomingAssessmentSection(assessments: upcomingAssessments),
      //     ],
      //   );
      // },
    );
  }
}
