import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../widgets/login_desktop_layout.dart';
import '../widgets/login_mobile_layout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final studentIdController = TextEditingController();
  final passwordController = TextEditingController();

  late final AuthController authController;

  @override
  void initState() {
    super.initState();

    authController = Get.find<AuthController>();
  }

  @override
  void dispose() {
    studentIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final success = await authController.login(
      studentNumber: studentIdController.text,
      password: passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      Get.offAllNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 900;

          if (isDesktop) {
            return LoginDesktopLayout(
              formKey: formKey,
              studentIdController: studentIdController,
              passwordController: passwordController,
              authController: authController,
              onLogin: login,
            );
          }

          return LoginMobileLayout(
            formKey: formKey,
            studentIdController: studentIdController,
            passwordController: passwordController,
            authController: authController,
            onLogin: login,
          );
        },
      ),
    );
  }
}