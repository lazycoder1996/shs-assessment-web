import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../controllers/auth_controller.dart';
import '../pages/login_page.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController identifierController;
  final TextEditingController passwordController;
  final AuthController authController;
  final LoginAccountType accountType;
  final ValueChanged<LoginAccountType> onAccountTypeChanged;
  final VoidCallback onLogin;

  const LoginForm({
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
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final isTutor =
        widget.accountType == LoginAccountType.tutor;

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
            isTutor
                ? 'Sign in to manage your assessments.'
                : 'Sign in to continue to your assessment.',
            style: AppTextStyles.body,
          ),

          const SizedBox(height: 28),

          _AccountTypeSelector(
            value: widget.accountType,
            onChanged: widget.onAccountTypeChanged,
          ),

          const SizedBox(height: 32),

          Text(
            isTutor ? 'Staff ID' : 'Student ID',
            style: AppTextStyles.bodyMedium,
          ),

          const SizedBox(height: 8),

          TextFormField(
            controller: widget.identifierController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: isTutor
                  ? 'Enter your staff ID'
                  : 'Enter your student ID',
              prefixIcon: const Icon(
                Icons.badge_outlined,
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return isTutor
                    ? 'Enter your staff ID'
                    : 'Enter your student ID';
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
                  : Text(
                      isTutor ? 'Sign In as Tutor' : 'Sign In',
                    ),
            );
          }),

          const SizedBox(height: 20),

          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Need help signing in?',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountTypeSelector extends StatelessWidget {
  final LoginAccountType value;
  final ValueChanged<LoginAccountType> onChanged;

  const _AccountTypeSelector({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: _AccountTypeButton(
              label: 'Student',
              icon: Icons.school_outlined,
              selected:
                  value == LoginAccountType.student,
              onTap: () {
                onChanged(LoginAccountType.student);
              },
            ),
          ),
          Expanded(
            child: _AccountTypeButton(
              label: 'Tutor',
              icon: Icons.person_outline,
              selected:
                  value == LoginAccountType.tutor,
              onTap: () {
                onChanged(LoginAccountType.tutor);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountTypeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _AccountTypeButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? Theme.of(context).colorScheme.surface
          : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 19,
              ),
              const SizedBox(width: 8),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}