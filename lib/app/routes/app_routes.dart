import 'package:get/get.dart';
import 'package:quiz_assessment/app/pages/app_startup_page.dart';
import 'package:quiz_assessment/features/assessment/presentation/screens/assessment_details.dart';
import 'package:quiz_assessment/features/assessment/presentation/screens/assessment_page.dart';
import 'package:quiz_assessment/features/assessment/presentation/screens/assessment_result_page.dart';
import 'package:quiz_assessment/features/assessment/presentation/screens/assessment_review_screen.dart';
import 'package:quiz_assessment/features/auth/pages/login_page.dart';
import 'package:quiz_assessment/features/home/pages/home_page.dart';
import 'package:quiz_assessment/features/tutor/pages/tutor_assessment_result_page.dart';
import 'package:quiz_assessment/features/tutor/pages/tutor_student_review_view.dart';

abstract final class AppRoutes {
  static const root = '/';
  static const login = '/login';
  static const home = '/home';
  static const _assessmentDetails = '/assessment-details/:assessmentId';
  static assessmentDetailsPage(String id) =>
      _assessmentDetails.replaceFirst(':assessmentId', id);
  static const _assessment = '/assessment/:assessmentId';
  static assessmentPage(String id) =>
      _assessment.replaceFirst(':assessmentId', id);
  static const startup = '/startup';
  static const _assessmentResult = '/assessment-result/:assessmentId';
  static assessmentResultPage(String id) =>
      _assessmentResult.replaceFirst(':assessmentId', id);
  static const _assessmentReview = '/assessment-review/:attemptId';
  static assessmentReviewPage(String id) =>
      _assessmentReview.replaceFirst(':attemptId', id);
  static const _tutorStudentResults = '/tutor/assessment-results/:assessmentId';
  static tutorStudentResultsPage(String id) =>
      _tutorStudentResults.replaceFirst(':assessmentId', id);

  static const _tutorStudentReview = '/tutor/student-review/:attemptId';
  static tutorStudentReviewPage(String id) =>
      _tutorStudentReview.replaceFirst(':attemptId', id);

  static var pages = [
    GetPage(name: root, page: () => const AppStartupPage()),
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(name: home, page: () => const HomePage()),
    GetPage(name: _assessment, page: () => const AssessmentPage()),
    GetPage(
      name: _assessmentDetails,
      page: () => const AssessmentDetailsPage(),
    ),
    GetPage(name: _assessmentResult, page: () => const AssessmentResultPage()),
    GetPage(name: _assessmentReview, page: () => const AssessmentReviewView()),
    GetPage(
      name: _tutorStudentReview,
      page: () => const TutorStudentReviewPage(),
    ),
    GetPage(name: _tutorStudentResults, page: () => AssessmentResultsPage()),
  ];
}
