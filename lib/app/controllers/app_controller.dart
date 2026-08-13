import 'package:get/get.dart';

import '../../features/assessment/services/assessment_clock_service.dart';
import '../../features/auth/controllers/auth_controller.dart';
import '../../core/network/api_client.dart';

class AppController extends GetxController {
  final AuthController authController;
  final ApiClient apiClient;
  final AssessmentClockService clockService;

  AppController({
    required this.authController,
    required this.apiClient,
    required this.clockService,
  });

  final isReady = false.obs;

  @override
  void onReady() {
    super.onReady();
    initialize();
  }

  Future<void> initialize() async {
    await authController.restoreSession();

    try {
      final serverTime = await apiClient.getServerTime();

      clockService.synchronize(serverTime);
    } catch (_) {
      // Fall back to device time if
      // server synchronization fails.
    }

    isReady.value = true;
  }
}
