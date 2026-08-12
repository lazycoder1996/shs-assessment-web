import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';
import 'login_form.dart';

class LoginMobileLayout extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController studentIdController;
  final TextEditingController passwordController;
  final AuthController authController;
  final VoidCallback onLogin;

  const LoginMobileLayout({
    super.key,
    required this.formKey,
    required this.studentIdController,
    required this.passwordController,
    required this.authController,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 32,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 440,
            ),
            child: LoginForm(
              formKey: formKey,
              studentIdController: studentIdController,
              passwordController: passwordController,
              authController: authController,
              onLogin: onLogin,
            ),
          ),
        ),
      ),
    );
  }
}