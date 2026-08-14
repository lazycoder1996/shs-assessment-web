import 'package:get/get.dart';
import 'package:quiz_assessment/core/network/api_client.dart';
import 'package:quiz_assessment/features/tutor/services/tutor_home_service.dart';

import '../models/tutor_assessment.dart';

class TutorHomeController extends GetxController {
  final TutorHomeService _service;

  TutorHomeController({required TutorHomeService service}) : _service = service;

  final isLoading = false.obs;
  final errorMessage = RxnString();

  final assessments = <TutorAssessment>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAssessments();
  }

  Future<void> loadAssessments() async {
    errorMessage.value = null;
    isLoading.value = true;

    try {
      final results = await _service.getAssessments();

      assessments.assignAll(results);
    } on ApiException catch (e) {
      errorMessage.value = e.message;
    } catch (e) {
      errorMessage.value = 'Unable to load assessments.';
    } finally {
      isLoading.value = false;
    }
  }
}
