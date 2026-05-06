import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/controllers/forgot_password_controller.dart';
import 'package:chat_app/features/widgets/forgot_password_form.dart';
import 'package:chat_app/features/widgets/forgot_password_success.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppPaddings.block),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacings.hero),
                Row(
                  children: [
                    IconButton(
                      onPressed: controller.goBackToLogin,
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: AppSpacings.sm),
                    Text(
                      context.loc.forgotPassword,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacings.sm),
                Padding(
                  padding: const EdgeInsets.only(left: AppPaddings.jumbo),
                  child: Text(
                    context.loc.forgotPasswordSubtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacings.jumbo),
                Center(
                  child: Container(
                    width: AppConstants.forgotPasswordIconContainerSize,
                    height: AppConstants.forgotPasswordIconContainerSize,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(
                        AppRadius.forgotPasswordIconContainerRadius,
                      ),
                    ),
                    child: const Icon(
                      Icons.lock_reset_rounded,
                      size: AppConstants.forgotPasswordIconSize,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacings.hero),
                Obx(
                  () => controller.emailSent
                      ? ForgotPasswordSuccess(controller: controller)
                      : ForgotPasswordForm(controller: controller),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}