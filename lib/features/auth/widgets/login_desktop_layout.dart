import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';
import 'login_brand_panel.dart';
import 'login_form.dart';

class LoginDesktopLayout extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController studentIdController;
  final TextEditingController passwordController;
  final AuthController authController;
  final VoidCallback onLogin;

  const LoginDesktopLayout({
    super.key,
    required this.formKey,
    required this.studentIdController,
    required this.passwordController,
    required this.authController,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: LoginBrandPanel(),
        ),
        Expanded(
          flex: 4,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(48),
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
        ),
      ],
    );
  }
}