import 'package:chat_app/core/constants/app_paddings.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/controllers/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController());

    return Scaffold(
      appBar: AppBar(title: Text(context.loc.changePassword)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppPaddings.block),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSpacings.lg),
                Center(
                  child: Container(
                    height: AppSpacings.large,
                    width: AppSpacings.large,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppRadius.hero),
                    ),
                    child: Icon(
                      Icons.security_rounded,
                      size: AppSpacings.hero,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                SizedBox(height: AppSpacings.xxl),
                Text(
                  context.loc.changePasswordTitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSpacings.sm),
                Text(
                  context.loc.changePasswordSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: AppSpacings.screen),
                Obx(
                  () => TextFormField(
                    controller: controller.currentPasswordController,
                    obscureText: controller.obscureCurrentPassword,
                    decoration: InputDecoration(
                      labelText: context.loc.currentPasswordHint,
                      prefixIcon: const Icon(Icons.lock_outline),
                      hintText: context.loc.currentPasswordHint,
                      suffixIcon: IconButton(
                        onPressed: controller.toggleCurrentPasswordVisibility,
                        icon: Icon(
                          controller.obscureCurrentPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                    validator: controller.validateCurrentPassword,
                  ),
                ),
                SizedBox(height: AppSpacings.lg),
                Obx(
                  () => TextFormField(
                    controller: controller.newPasswordController,
                    obscureText: controller.obscureNewPassword,
                    decoration: InputDecoration(
                      labelText: context.loc.newPasswordHint,
                      prefixIcon: const Icon(Icons.lock_outline),
                      hintText: context.loc.newPasswordHint,
                      suffixIcon: IconButton(
                        onPressed: controller.toggleNewPasswordVisibility,
                        icon: Icon(
                          controller.obscureNewPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                    validator: controller.validateNewPassword,
                  ),
                ),
                SizedBox(height: AppSpacings.lg),
                Obx(
                  () => TextFormField(
                    controller: controller.confirmPasswordController,
                    obscureText: controller.obscureConfirmPassword,
                    decoration: InputDecoration(
                      labelText: context.loc.confirmPasswordHint,
                      prefixIcon: const Icon(Icons.lock_outline),
                      hintText: context.loc.confirmPasswordHint,
                      suffixIcon: IconButton(
                        onPressed: controller.toggleConfirmPasswordVisibility,
                        icon: Icon(
                          controller.obscureConfirmPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                    validator: controller.validateConfirmpassword,
                  ),
                ),
                SizedBox(height: AppSpacings.screen),
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: controller.isLoading
                          ? null
                          : controller.changePassword,
                      icon: controller.isLoading
                          ? SizedBox(
                              height: AppSpacings.xl,
                              width: AppSpacings.xl,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.security),
                      label: Text(
                        controller.isLoading
                            ? context.loc.updating
                            : context.loc.updatePassword,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}