import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/app_controller.dart';
import '../routes/app_routes.dart';

class AppStartupPage extends GetView<AppController> {
  const AppStartupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.isReady.value) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!controller.authController.isAuthenticated) {
          Get.offAllNamed(AppRoutes.login);
          return;
        }

        final path = Uri.base.path;

        if (path == '/' || path == AppRoutes.startup) {
          Get.offAllNamed(AppRoutes.home);
          return;
        }

        // Browser already requested a specific page.
        Get.offAllNamed(path);
      });

      return const Scaffold(body: SizedBox.shrink());
    });
  }
}
