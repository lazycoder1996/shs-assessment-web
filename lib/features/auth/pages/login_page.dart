import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../widgets/login_desktop_layout.dart';
import '../widgets/login_mobile_layout.dart';

enum LoginAccountType {
  student,
  tutor,
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final identifierController = TextEditingController();
  final passwordController = TextEditingController();

  late final AuthController authController;

  LoginAccountType accountType = LoginAccountType.student;

  @override
  void initState() {
    super.initState();

    authController = Get.find<AuthController>();
  }

  @override
  void dispose() {
    identifierController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final success = accountType == LoginAccountType.student
        ? await authController.login(
            studentNumber: identifierController.text,
            password: passwordController.text,
          )
        : await authController.loginTutor(
            staffNumber: identifierController.text,
            password: passwordController.text,
          );

    if (!mounted || !success) {
      return;
    }

    if (accountType == LoginAccountType.student) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/tutor');
    }
  }

  void changeAccountType(LoginAccountType type) {
    if (accountType == type) {
      return;
    }

    setState(() {
      accountType = type;
      identifierController.clear();
      passwordController.clear();
      formKey.currentState?.reset();
    });

    authController.errorMessage.value = null;
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
              identifierController: identifierController,
              passwordController: passwordController,
              authController: authController,
              accountType: accountType,
              onAccountTypeChanged: changeAccountType,
              onLogin: login,
            );
          }

          return LoginMobileLayout(
            formKey: formKey,
            identifierController: identifierController,
            passwordController: passwordController,
            authController: authController,
            accountType: accountType,
            onAccountTypeChanged: changeAccountType,
            onLogin: login,
          );
        },
      ),
    );
  }
}