import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../features/auth/controllers/auth_controller.dart';
import '../routes/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  GetPage? onPageCalled(GetPage? page) {
    final authController = Get.find<AuthController>();

    if (!authController.isAuthenticated) {
      return GetPage(
        name: AppRoutes.login,
        page: () => const SizedBox(),
      );
    }

    return page;
  }
}