import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/extensions/context_extention.dart';
import 'package:chat_app/features/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/core/router/app_routes.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/controllers/forgot_password_controller.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({super.key, required this.controller});

  final ForgotPasswordController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: context.loc.emailAddressHint,
            prefixIcon: const Icon(Icons.email_outlined),
            hintText: context.loc.emailAddressHint,
          ),
          validator: controller.validateEmail,
        ),
        const SizedBox(height: AppSpacings.xxl),
        Obx(
          () => AuthButton(
            text: context.loc.sendResetLink,
            onPressed: controller.sendPasswordResetEmail,
            isLoading: controller.isLoading,
          ),
        ),
        const SizedBox(height: AppSpacings.xxl),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.loc.rememberPassword,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.login),
              child: Text(
                context.loc.signIn,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}