import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../controllers/auth_controller.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController studentIdController;
  final TextEditingController passwordController;
  final AuthController authController;
  final VoidCallback onLogin;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.studentIdController,
    required this.passwordController,
    required this.authController,
    required this.onLogin,
  });

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back 👋',
            style: AppTextStyles.headingMedium,
          ),

          const SizedBox(height: 8),

          Text(
            'Sign in to continue to your assessment.',
            style: AppTextStyles.body,
          ),

          const SizedBox(height: 36),

          Text(
            'Student ID',
            style: AppTextStyles.bodyMedium,
          ),

          const SizedBox(height: 8),

          TextFormField(
            controller: widget.studentIdController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              hintText: 'Enter your student ID',
              prefixIcon: Icon(Icons.badge_outlined),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Enter your student ID';
              }

              return null;
            },
          ),

          const SizedBox(height: 20),

          Text(
            'Password',
            style: AppTextStyles.bodyMedium,
          ),

          const SizedBox(height: 8),

          TextFormField(
            controller: widget.passwordController,
            obscureText: obscurePassword,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => widget.onLogin(),
            decoration: InputDecoration(
              hintText: 'Enter your password',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter your password';
              }

              return null;
            },
          ),

          const SizedBox(height: 16),

          Obx(() {
            final errorMessage =
                widget.authController.errorMessage.value;

            if (errorMessage == null) {
              return const SizedBox.shrink();
            }

            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                errorMessage,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.error,
                ),
              ),
            );
          }),

          Obx(() {
            final isLoading =
                widget.authController.isLoading.value;

            return ElevatedButton(
              onPressed: isLoading ? null : widget.onLogin,
              child: isLoading
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Sign In'),
            );
          }),

          const SizedBox(height: 20),

          Center(
            child: TextButton(
              onPressed: () {
                // Password recovery will be added later.
              },
              child: const Text('Need help signing in?'),
            ),
          ),
        ],
      ),
    );
  }
}