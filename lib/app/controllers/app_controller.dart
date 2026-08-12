import 'package:get/get.dart';

import '../../features/auth/controllers/auth_controller.dart';

class AppController extends GetxController {
  final AuthController authController;

  AppController({
    required this.authController,
  });

  final isReady = false.obs;

  @override
  void onReady() {
    super.onReady();
    initialize();
  }

  Future<void> initialize() async {
    await authController.restoreSession();

    isReady.value = true;
  }
}