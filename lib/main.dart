import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quiz_assessment/core/bindings/app_bindings.dart';
import 'package:quiz_assessment/features/auth/controllers/auth_controller.dart';

import 'app/routes/app_routes.dart';
import 'app/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bindings = AppBindings();
  bindings.dependencies();

  final authController = Get.find<AuthController>();

  await authController.restoreSession();

  runApp(const SHSAssessmentApp());
}

class SHSAssessmentApp extends StatelessWidget {
  const SHSAssessmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: Size(375, 667),
    );
    return GetMaterialApp(
      title: 'SHS Assess',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      smartManagement: SmartManagement.onlyBuilder,
      initialBinding: AppBindings(),
      getPages: AppRoutes.pages,
      // initialRoute: AppRoutes.startup,
    );
  }
}
