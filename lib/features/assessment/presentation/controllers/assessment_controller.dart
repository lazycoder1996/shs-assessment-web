import 'dart:async';

import 'package:get/get.dart';
import 'package:quiz_assessment/features/assessment/data/models/assessment.dart';
import 'package:quiz_assessment/features/assessment/services/assessment_service.dart';

class AssessmentController extends GetxController {
  final AssessmentService assessmentService;

  AssessmentController({required this.assessmentService});

  final assessments = <Assessment>[].obs;

  final isLoading = false.obs;

  final errorMessage = RxnString();

  Timer? _statusTimer;

  @override
  void onInit() {
    super.onInit();

    loadAssessments();

    _statusTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      assessments.refresh();
    });
  }

  @override
  void onClose() {
    _statusTimer?.cancel();
    super.onClose();
  }

  Future<void> loadAssessments() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      final results = await assessmentService.getAssessments();

      assessments.assignAll(results);
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  List<Assessment> get liveAssessments {
    return assessments.where((assessment) => assessment.isLive).toList();
  }

  List<Assessment> get upcomingAssessments {
    return assessments.where((assessment) => assessment.isUpcoming).toList();
  }

  List<Assessment> get completedAssessments {
    return assessments.where((assessment) => assessment.isCompleted).toList();
  }

  List<Assessment> get closedAssessments {
    return assessments.where((assessment) => assessment.isExpired).toList();
  }
}
