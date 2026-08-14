import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';
import '../pages/login_page.dart';
import 'login_brand_panel.dart';
import 'login_form.dart';

class LoginDesktopLayout extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController identifierController;
  final TextEditingController passwordController;
  final AuthController authController;
  final LoginAccountType accountType;
  final ValueChanged<LoginAccountType> onAccountTypeChanged;
  final VoidCallback onLogin;

  const LoginDesktopLayout({
    super.key,
    required this.formKey,
    required this.identifierController,
    required this.passwordController,
    required this.authController,
    required this.accountType,
    required this.onAccountTypeChanged,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
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
                  identifierController: identifierController,
                  passwordController: passwordController,
                  authController: authController,
                  accountType: accountType,
                  onAccountTypeChanged: onAccountTypeChanged,
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