import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/core/constants/app_radius.dart';
import 'package:chat_app/core/constants/app_spacings.dart';
import 'package:chat_app/core/extensions/context_extention.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/controllers/forgot_password_controller.dart';

class ForgotPasswordSuccess extends StatelessWidget {
  const ForgotPasswordSuccess({super.key, required this.controller});

  final ForgotPasswordController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SuccessCard(email: controller.emailController.text),
        const SizedBox(height: AppSpacings.xxl),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: controller.resendEmail,
            icon: const Icon(Icons.refresh),
            label: Text(context.loc.resendEmail),
          ),
        ),
        const SizedBox(height: AppSpacings.xxl),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.info_outline,
              size: AppConstants.infoIconSize,
              color: AppColors.secondary,
            ),
            const SizedBox(width: AppSpacings.lg),
            Expanded(
              child: Text(
                context.loc.checkSpamNote,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.secondary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SuccessCard extends StatelessWidget {
  const _SuccessCard({required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacings.block),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.mark_email_read_rounded,
            size: AppConstants.successIconSize,
            color: AppColors.success,
          ),
          const SizedBox(height: AppSpacings.xxl),
          Text(
            context.loc.emailSentTitle,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.success,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacings.sm),
          Text(
            context.loc.emailSentTo,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacings.xxs),
          Text(
            email,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacings.lg),
          Text(
            context.loc.emailSentInstruction,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}