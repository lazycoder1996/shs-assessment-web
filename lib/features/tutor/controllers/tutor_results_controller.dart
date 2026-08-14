import 'dart:async';

import 'package:get/get.dart';
import 'package:quiz_assessment/core/network/api_client.dart';
import 'package:quiz_assessment/features/assessment/data/models/assessment_review.dart';
import 'package:quiz_assessment/features/tutor/services/tutor_result_service.dart';

import '../models/student_result_summary.dart';

class TutorResultsController extends GetxController {
  final TutorResultService service;

  TutorResultsController({required this.service});

  final results = <StudentResultSummary>[].obs;

  final isLoading = false.obs;
  final errorMessage = RxnString();

  final searchText = ''.obs;

  Timer? _searchTimer;

  late String assessmentId;
  // late String assessmentTitle;
  // late String assessmentSubject;
  final isLoadingResults = false.obs;
  final isLoadingReview = false.obs;

  Future<void> loadResults(String assessmentId) async {
    this.assessmentId = assessmentId;

    errorMessage.value = null;
    isLoadingResults.value = true;

    try {
      final response = await service.getResults(
        assessmentId: assessmentId,
        search: searchText.value,
      );

      results.assignAll(response);
    } catch (e) {
      errorMessage.value = 'Unable to load student results. $e';
    } finally {
      isLoadingResults.value = false;
    }
  }

  void search(String value) {
    searchText.value = value;

    _searchTimer?.cancel();

    _searchTimer = Timer(const Duration(milliseconds: 400), () {
      loadResults(assessmentId);
    });
  }

  @override
  void onClose() {
    _searchTimer?.cancel();
    super.onClose();
  }

  final review = Rxn<AssessmentReview>();

  Future<void> loadReview(String attemptId) async {
    errorMessage.value = null;
    isLoadingReview.value = true;

    try {
      review.value = await service.getAttemptReview(attemptId: attemptId);
    } on ApiException catch (e) {
      errorMessage.value = e.message;
    } catch (_) {
      errorMessage.value = 'Unable to load the student review.';
    } finally {
      isLoadingReview.value = false;
    }
  }

  void clear() {
    review.value = null;
    errorMessage.value = null;
  }
}
