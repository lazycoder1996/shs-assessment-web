import 'package:get/get.dart';
import 'package:quiz_assessment/features/assessment/data/assessment_review_repository.dart';
import 'package:quiz_assessment/features/assessment/data/models/assessment_review.dart';

class AssessmentReviewController extends GetxController {
  final AssessmentReviewRepository repository;

  AssessmentReviewController({
    required this.repository,
  });

  final isLoading = true.obs;
  final errorMessage = RxnString();
  final review = Rxn<AssessmentReview>();

  Future<void> loadReview(String attemptId) async {
    try {
      isLoading.value = true;
      errorMessage.value = null;

      review.value = await repository.getReview(attemptId);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}